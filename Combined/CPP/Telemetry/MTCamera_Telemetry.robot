*** Settings ***
Documentation    MTCamera Telemetry communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${timeout}    ${subSystem}    ${component}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTCamera
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
    Should Contain    ${output}    ===== MTCamera subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_quadbox_BFR test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_BFR
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_quadbox_BFR start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_BFR_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_quadbox_BFR end of topic ===
    Comment    ======= Verify ${subSystem}_quadbox_PDU_5V test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_PDU_5V
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_quadbox_PDU_5V start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_PDU_5V_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_quadbox_PDU_5V end of topic ===
    Comment    ======= Verify ${subSystem}_quadbox_PDU_24VC test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_PDU_24VC
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_quadbox_PDU_24VC start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_PDU_24VC_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_quadbox_PDU_24VC end of topic ===
    Comment    ======= Verify ${subSystem}_quadbox_PDU_24VD test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_PDU_24VD
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_quadbox_PDU_24VD start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_PDU_24VD_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_quadbox_PDU_24VD end of topic ===
    Comment    ======= Verify ${subSystem}_quadbox_PDU_48V test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_PDU_48V
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_quadbox_PDU_48V start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_PDU_48V_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_quadbox_PDU_48V end of topic ===
    Comment    ======= Verify ${subSystem}_quadbox_REB_Bulk_PS test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_quadbox_REB_Bulk_PS
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_quadbox_REB_Bulk_PS start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::quadbox_REB_Bulk_PS_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_quadbox_REB_Bulk_PS end of topic ===
    Comment    ======= Verify ${subSystem}_rebpower_Rebps test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_rebpower_Rebps
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_rebpower_Rebps start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::rebpower_Rebps_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_rebpower_Rebps end of topic ===
    Comment    ======= Verify ${subSystem}_rebpower_Reb test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_rebpower_Reb
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_rebpower_Reb start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::rebpower_Reb_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_rebpower_Reb end of topic ===
    Comment    ======= Verify ${subSystem}_hex_Cold1 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hex_Cold1
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_hex_Cold1 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::hex_Cold1_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_hex_Cold1 end of topic ===
    Comment    ======= Verify ${subSystem}_hex_Cold2 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hex_Cold2
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_hex_Cold2 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::hex_Cold2_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_hex_Cold2 end of topic ===
    Comment    ======= Verify ${subSystem}_hex_Cryo5 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hex_Cryo5
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo5 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::hex_Cryo5_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo5 end of topic ===
    Comment    ======= Verify ${subSystem}_hex_Cryo6 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hex_Cryo6
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo6 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::hex_Cryo6_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo6 end of topic ===
    Comment    ======= Verify ${subSystem}_hex_Cryo4 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hex_Cryo4
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo4 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::hex_Cryo4_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo4 end of topic ===
    Comment    ======= Verify ${subSystem}_hex_Cryo3 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hex_Cryo3
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo3 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::hex_Cryo3_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo3 end of topic ===
    Comment    ======= Verify ${subSystem}_hex_Cryo2 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hex_Cryo2
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo2 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::hex_Cryo2_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo2 end of topic ===
    Comment    ======= Verify ${subSystem}_hex_Cryo1 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_hex_Cryo1
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo1 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::hex_Cryo1_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_hex_Cryo1 end of topic ===
    Comment    ======= Verify ${subSystem}_refrig_Cold1 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_refrig_Cold1
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cold1 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::refrig_Cold1_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cold1 end of topic ===
    Comment    ======= Verify ${subSystem}_refrig_Cold2 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_refrig_Cold2
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cold2 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::refrig_Cold2_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cold2 end of topic ===
    Comment    ======= Verify ${subSystem}_refrig_Cryo5 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_refrig_Cryo5
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo5 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::refrig_Cryo5_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo5 end of topic ===
    Comment    ======= Verify ${subSystem}_refrig_Cryo6 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_refrig_Cryo6
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo6 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::refrig_Cryo6_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo6 end of topic ===
    Comment    ======= Verify ${subSystem}_refrig_Cryo4 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_refrig_Cryo4
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo4 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::refrig_Cryo4_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo4 end of topic ===
    Comment    ======= Verify ${subSystem}_refrig_Cryo3 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_refrig_Cryo3
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo3 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::refrig_Cryo3_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo3 end of topic ===
    Comment    ======= Verify ${subSystem}_refrig_Cryo2 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_refrig_Cryo2
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo2 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::refrig_Cryo2_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo2 end of topic ===
    Comment    ======= Verify ${subSystem}_refrig_Cryo1 test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_refrig_Cryo1
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo1 start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::refrig_Cryo1_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_refrig_Cryo1 end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_IonPumps test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_IonPumps
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_vacuum_IonPumps start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_IonPumps_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_vacuum_IonPumps end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_TurboPump test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_TurboPump
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_vacuum_TurboPump start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_TurboPump_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_vacuum_TurboPump end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_CryoVacGauge test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_CryoVacGauge
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_vacuum_CryoVacGauge start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_CryoVacGauge_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_vacuum_CryoVacGauge end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_TurboVacGauge test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_TurboVacGauge
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_vacuum_TurboVacGauge start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_TurboVacGauge_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_vacuum_TurboVacGauge end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_ForelineVacGauge test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_ForelineVacGauge
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_vacuum_ForelineVacGauge start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_ForelineVacGauge_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_vacuum_ForelineVacGauge end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_Hex1VacGauge test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_Hex1VacGauge
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_vacuum_Hex1VacGauge start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_Hex1VacGauge_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_vacuum_Hex1VacGauge end of topic ===
    Comment    ======= Verify ${subSystem}_vacuum_Hex2VacGauge test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_Hex2VacGauge
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_vacuum_Hex2VacGauge start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_Hex2VacGauge_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_vacuum_Hex2VacGauge end of topic ===
    Comment    ======= Verify ${subSystem}_daq_monitor_Store test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_daq_monitor_Store
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_daq_monitor_Store start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::daq_monitor_Store_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_daq_monitor_Store end of topic ===
    Comment    ======= Verify ${subSystem}_focal_plane_Reb test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_focal_plane_Reb
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_focal_plane_Reb start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::focal_plane_Reb_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_focal_plane_Reb end of topic ===
    Comment    ======= Verify ${subSystem}_focal_plane_Ccd test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_focal_plane_Ccd
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_focal_plane_Ccd start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::focal_plane_Ccd_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_focal_plane_Ccd end of topic ===
    Comment    ======= Verify ${subSystem}_focal_plane_Segment test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_focal_plane_Segment
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_focal_plane_Segment start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::focal_plane_Segment_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_focal_plane_Segment end of topic ===
    Comment    ======= Verify ${subSystem}_focal_plane_RebTotalPower test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_focal_plane_RebTotalPower
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === MTCamera_focal_plane_RebTotalPower start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::focal_plane_RebTotalPower_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_focal_plane_RebTotalPower end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    ${subSystem}_Subscriber
    ${output}=    Wait For Process    ${subSystem}_Subscriber    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${quadbox_BFR_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR start of topic ===
    ${quadbox_BFR_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_BFR end of topic ===
    ${quadbox_BFR_list}=    Get Slice From List    ${full_list}    start=${quadbox_BFR_start}    end=${quadbox_BFR_end}
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}protection_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clean_5_24V_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dirty_24V_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dirty_48V_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebps_0_2_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebps_3_5_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebps_6_8_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebps_9_12_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dirty_28V_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_I : 1    10
    Should Contain X Times    ${quadbox_BFR_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebps_Spr_I : 1    10
    ${quadbox_PDU_5V_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V start of topic ===
    ${quadbox_PDU_5V_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_5V end of topic ===
    ${quadbox_PDU_5V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_5V_start}    end=${quadbox_PDU_5V_end}
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_0_A_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_0_A_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_0_B_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_0_B_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_1_A_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_1_A_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_1_B_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_1_B_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_2_A_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_2_A_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_2_B_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_2_B_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_3_A_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_3_A_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_3_B_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_3_B_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_4_A_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_4_A_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_4_B_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_4_B_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_5_A_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_5_A_I : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_5_B_V : 1    10
    Should Contain X Times    ${quadbox_PDU_5V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otm_5_B_I : 1    10
    ${quadbox_PDU_24VC_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC start of topic ===
    ${quadbox_PDU_24VC_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VC end of topic ===
    ${quadbox_PDU_24VC_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VC_start}    end=${quadbox_PDU_24VC_end}
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}board_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fPGA_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pwr_Cry_HCU_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pwr_Cry_HCU_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fes_Shu_HCU_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fes_Shu_HCU_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ion_Pumps_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ion_Pumps_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}body_Purge_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}body_Purge_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bpu_Maq20_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bpu_Maq20_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gauges_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VC_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gauges_I : 1    10
    ${quadbox_PDU_24VD_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD start of topic ===
    ${quadbox_PDU_24VD_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_24VD end of topic ===
    ${quadbox_PDU_24VD_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_24VD_start}    end=${quadbox_PDU_24VD_end}
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}board_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fPGA_T : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryo_Turbo_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryo_Turbo_I : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hex_Turbo_V : 1    10
    Should Contain X Times    ${quadbox_PDU_24VD_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hex_Turbo_I : 1    10
    ${quadbox_PDU_48V_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V start of topic ===
    ${quadbox_PDU_48V_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_PDU_48V end of topic ===
    ${quadbox_PDU_48V_list}=    Get Slice From List    ${full_list}    start=${quadbox_PDU_48V_start}    end=${quadbox_PDU_48V_end}
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_V : 1    10
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_I : 1    10
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}main_T : 1    10
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}board_T : 1    10
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fPGA_T : 1    10
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}purge_Fan_V : 1    10
    Should Contain X Times    ${quadbox_PDU_48V_list}    ${SPACE}${SPACE}${SPACE}${SPACE}purge_Fan_I : 1    10
    ${quadbox_REB_Bulk_PS_start}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS start of topic ===
    ${quadbox_REB_Bulk_PS_end}=    Get Index From List    ${full_list}    === MTCamera_quadbox_REB_Bulk_PS end of topic ===
    ${quadbox_REB_Bulk_PS_list}=    Get Slice From List    ${full_list}    start=${quadbox_REB_Bulk_PS_start}    end=${quadbox_REB_Bulk_PS_end}
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_Brd_T : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_0_2_V : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_0_2_I : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_0_2_T : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_3_5_V : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_3_5_I : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_3_5_T : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_6_8_V : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_6_8_I : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_6_8_T : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_9_12_V : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_9_12_I : 1    10
    Should Contain X Times    ${quadbox_REB_Bulk_PS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebbulkps_9_12_T : 1    10
    ${rebpower_Rebps_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps start of topic ===
    ${rebpower_Rebps_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Rebps end of topic ===
    ${rebpower_Rebps_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_start}    end=${rebpower_Rebps_end}
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 0    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 1    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 2    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 3    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 4    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 5    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 6    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 7    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 8    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 9    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 0    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 1    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 2    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 3    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 4    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 5    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 6    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 7    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 8    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 9    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 0    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 1    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 2    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 3    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 4    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 5    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 6    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 7    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 8    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 9    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 0    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 1    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 2    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 3    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 4    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 5    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 6    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 7    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 8    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 9    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 0    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 1    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 2    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 3    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 4    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 5    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 6    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 7    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 8    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 9    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 0    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 1    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 2    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 3    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 4    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 5    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 6    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 7    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 8    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 9    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 0    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 1    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 2    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 3    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 4    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 5    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 6    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 7    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 8    1
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 9    1
    ${rebpower_Reb_start}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb start of topic ===
    ${rebpower_Reb_end}=    Get Index From List    ${full_list}    === MTCamera_rebpower_Reb end of topic ===
    ${rebpower_Reb_list}=    Get Slice From List    ${full_list}    start=${rebpower_Reb_start}    end=${rebpower_Reb_end}
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_IaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftSwch : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftSwch : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftSwch : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftSwch : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftSwch : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftSwch : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftSwch : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftSwch : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftSwch : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digital_VaftSwch : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_IaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftSwch : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftSwch : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftSwch : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftSwch : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftSwch : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftSwch : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftSwch : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftSwch : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftSwch : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}analog_VaftSwch : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO2 : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO2 : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO2 : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO2 : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO2 : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO2 : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO2 : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO2 : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO2 : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftLDO2 : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_IaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftSwch : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftSwch : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftSwch : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftSwch : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftSwch : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftSwch : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftSwch : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftSwch : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftSwch : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}od_VaftSwch : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_IaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftSwch : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftSwch : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftSwch : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftSwch : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftSwch : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftSwch : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftSwch : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftSwch : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftSwch : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockhi_VaftSwch : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO2 : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO2 : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO2 : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO2 : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO2 : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO2 : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO2 : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO2 : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO2 : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftLDO2 : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_IaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftSwch : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftSwch : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftSwch : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftSwch : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftSwch : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftSwch : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftSwch : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftSwch : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftSwch : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clocklo_VaftSwch : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_IaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftSwch : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftSwch : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftSwch : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftSwch : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftSwch : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftSwch : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftSwch : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftSwch : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftSwch : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dphi_VaftSwch : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_VbefSwch : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_VbefSwch : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_VbefSwch : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_VbefSwch : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_VbefSwch : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_VbefSwch : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_VbefSwch : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_VbefSwch : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_VbefSwch : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_VbefSwch : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_IbefSwch : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_IbefSwch : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_IbefSwch : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_IbefSwch : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_IbefSwch : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_IbefSwch : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_IbefSwch : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_IbefSwch : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_IbefSwch : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hvbias_IbefSwch : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IbefLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IbefLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IbefLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IbefLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IbefLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IbefLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IbefLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IbefLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IbefLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IbefLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IaftLDO : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IaftLDO : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IaftLDO : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IaftLDO : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IaftLDO : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IaftLDO : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IaftLDO : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IaftLDO : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IaftLDO : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_IaftLDO : 9    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftSwch : 0    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftSwch : 1    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftSwch : 2    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftSwch : 3    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftSwch : 4    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftSwch : 5    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftSwch : 6    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftSwch : 7    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftSwch : 8    1
    Should Contain X Times    ${rebpower_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heater_VaftSwch : 9    1
    ${hex_Cold1_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1 start of topic ===
    ${hex_Cold1_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold1 end of topic ===
    ${hex_Cold1_list}=    Get Slice From List    ${full_list}    start=${hex_Cold1_start}    end=${hex_Cold1_end}
    Should Contain X Times    ${hex_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}supplyTmp : 1    10
    Should Contain X Times    ${hex_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpnTmp : 1    10
    Should Contain X Times    ${hex_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}evapExitTmp : 1    10
    Should Contain X Times    ${hex_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexRtrnTmp : 1    10
    Should Contain X Times    ${hex_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}supplyPrs : 1    10
    Should Contain X Times    ${hex_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnPrs : 1    10
    Should Contain X Times    ${hex_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}superHeat : 1    10
    Should Contain X Times    ${hex_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}supplySubCooling : 1    10
    ${hex_Cold2_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2 start of topic ===
    ${hex_Cold2_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cold2 end of topic ===
    ${hex_Cold2_list}=    Get Slice From List    ${full_list}    start=${hex_Cold2_start}    end=${hex_Cold2_end}
    Should Contain X Times    ${hex_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}supplyTmp : 1    10
    Should Contain X Times    ${hex_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpnTmp : 1    10
    Should Contain X Times    ${hex_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}evapExitTmp : 1    10
    Should Contain X Times    ${hex_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexRtrnTmp : 1    10
    Should Contain X Times    ${hex_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}supplyPrs : 1    10
    Should Contain X Times    ${hex_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnPrs : 1    10
    Should Contain X Times    ${hex_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}superHeat : 1    10
    Should Contain X Times    ${hex_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}supplySubCooling : 1    10
    ${hex_Cryo5_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5 start of topic ===
    ${hex_Cryo5_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo5 end of topic ===
    ${hex_Cryo5_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo5_start}    end=${hex_Cryo5_end}
    Should Contain X Times    ${hex_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c3ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC3Tmp : 1    10
    Should Contain X Times    ${hex_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC4Tmp : 1    10
    Should Contain X Times    ${hex_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c4ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}evapExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexRtrnTmp : 1    10
    Should Contain X Times    ${hex_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vaporPrs : 1    10
    Should Contain X Times    ${hex_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidPrs : 1    10
    Should Contain X Times    ${hex_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnPrs : 1    10
    ${hex_Cryo6_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6 start of topic ===
    ${hex_Cryo6_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo6 end of topic ===
    ${hex_Cryo6_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo6_start}    end=${hex_Cryo6_end}
    Should Contain X Times    ${hex_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c3ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC3Tmp : 1    10
    Should Contain X Times    ${hex_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC4Tmp : 1    10
    Should Contain X Times    ${hex_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c4ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}evapExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexRtrnTmp : 1    10
    Should Contain X Times    ${hex_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vaporPrs : 1    10
    Should Contain X Times    ${hex_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidPrs : 1    10
    Should Contain X Times    ${hex_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnPrs : 1    10
    ${hex_Cryo4_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4 start of topic ===
    ${hex_Cryo4_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo4 end of topic ===
    ${hex_Cryo4_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo4_start}    end=${hex_Cryo4_end}
    Should Contain X Times    ${hex_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c3ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC3Tmp : 1    10
    Should Contain X Times    ${hex_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC4Tmp : 1    10
    Should Contain X Times    ${hex_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c4ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}evapExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexRtrnTmp : 1    10
    Should Contain X Times    ${hex_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vaporPrs : 1    10
    Should Contain X Times    ${hex_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidPrs : 1    10
    Should Contain X Times    ${hex_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnPrs : 1    10
    ${hex_Cryo3_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3 start of topic ===
    ${hex_Cryo3_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo3 end of topic ===
    ${hex_Cryo3_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo3_start}    end=${hex_Cryo3_end}
    Should Contain X Times    ${hex_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c3ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC3Tmp : 1    10
    Should Contain X Times    ${hex_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC4Tmp : 1    10
    Should Contain X Times    ${hex_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c4ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}evapExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexRtrnTmp : 1    10
    Should Contain X Times    ${hex_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vaporPrs : 1    10
    Should Contain X Times    ${hex_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidPrs : 1    10
    Should Contain X Times    ${hex_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnPrs : 1    10
    ${hex_Cryo2_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2 start of topic ===
    ${hex_Cryo2_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo2 end of topic ===
    ${hex_Cryo2_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo2_start}    end=${hex_Cryo2_end}
    Should Contain X Times    ${hex_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c3ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC3Tmp : 1    10
    Should Contain X Times    ${hex_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC4Tmp : 1    10
    Should Contain X Times    ${hex_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c4ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}evapExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexRtrnTmp : 1    10
    Should Contain X Times    ${hex_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vaporPrs : 1    10
    Should Contain X Times    ${hex_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidPrs : 1    10
    Should Contain X Times    ${hex_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnPrs : 1    10
    ${hex_Cryo1_start}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1 start of topic ===
    ${hex_Cryo1_end}=    Get Index From List    ${full_list}    === MTCamera_hex_Cryo1 end of topic ===
    ${hex_Cryo1_list}=    Get Slice From List    ${full_list}    start=${hex_Cryo1_start}    end=${hex_Cryo1_end}
    Should Contain X Times    ${hex_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c3ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC3Tmp : 1    10
    Should Contain X Times    ${hex_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preC4Tmp : 1    10
    Should Contain X Times    ${hex_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}c4ExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}evapExitTmp : 1    10
    Should Contain X Times    ${hex_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexRtrnTmp : 1    10
    Should Contain X Times    ${hex_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vaporPrs : 1    10
    Should Contain X Times    ${hex_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidPrs : 1    10
    Should Contain X Times    ${hex_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnPrs : 1    10
    ${refrig_Cold1_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1 start of topic ===
    ${refrig_Cold1_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold1 end of topic ===
    ${refrig_Cold1_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold1_start}    end=${refrig_Cold1_end}
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_P : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_M : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgPrs : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_P : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_M : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctionPrs : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidtmp_P : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidtmp_M : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVoltage : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compCurrent : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compPower : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVfdVolt : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVfdCurr : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVfdFreq : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hGBValvePosn : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolValvePosn : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolFlowRate : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterInTmp : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterOutTmp : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabinetTmp : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTmp : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan1Speed : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan2Speed : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan3Speed : 1    10
    Should Contain X Times    ${refrig_Cold1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidSubCooling : 1    10
    ${refrig_Cold2_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2 start of topic ===
    ${refrig_Cold2_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cold2 end of topic ===
    ${refrig_Cold2_list}=    Get Slice From List    ${full_list}    start=${refrig_Cold2_start}    end=${refrig_Cold2_end}
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_P : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_M : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgPrs : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_P : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_M : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctionPrs : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidtmp_P : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidtmp_M : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVoltage : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compCurrent : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compPower : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVfdVolt : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVfdCurr : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVfdFreq : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hGBValvePosn : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolValvePosn : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolFlowRate : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterInTmp : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterOutTmp : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabinetTmp : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTmp : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan1Speed : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan2Speed : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fan3Speed : 1    10
    Should Contain X Times    ${refrig_Cold2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}liquidSubCooling : 1    10
    ${refrig_Cryo5_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5 start of topic ===
    ${refrig_Cryo5_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo5 end of topic ===
    ${refrig_Cryo5_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo5_start}    end=${refrig_Cryo5_end}
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgPrs : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctionPrs : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilLevel : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVoltage : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compCurrent : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compPower : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterInTmp : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterOutTmp : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}afterCoolTmp : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}phaseSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}surgeTankTmp : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabinetTmp : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTmp : 1    10
    Should Contain X Times    ${refrig_Cryo5_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanSpeed : 1    10
    ${refrig_Cryo6_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6 start of topic ===
    ${refrig_Cryo6_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo6 end of topic ===
    ${refrig_Cryo6_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo6_start}    end=${refrig_Cryo6_end}
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgPrs : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctionPrs : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilLevel : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVoltage : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compCurrent : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compPower : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterInTmp : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterOutTmp : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}afterCoolTmp : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}phaseSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}surgeTankTmp : 1    10
    Should Contain X Times    ${refrig_Cryo6_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanSpeed : 1    10
    ${refrig_Cryo4_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4 start of topic ===
    ${refrig_Cryo4_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo4 end of topic ===
    ${refrig_Cryo4_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo4_start}    end=${refrig_Cryo4_end}
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgPrs : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctionPrs : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilLevel : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVoltage : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compCurrent : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compPower : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterInTmp : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterOutTmp : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}afterCoolTmp : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}phaseSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}surgeTankTmp : 1    10
    Should Contain X Times    ${refrig_Cryo4_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanSpeed : 1    10
    ${refrig_Cryo3_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3 start of topic ===
    ${refrig_Cryo3_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo3 end of topic ===
    ${refrig_Cryo3_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo3_start}    end=${refrig_Cryo3_end}
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgPrs : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctionPrs : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilLevel : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVoltage : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compCurrent : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compPower : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterInTmp : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterOutTmp : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}afterCoolTmp : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}phaseSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}surgeTankTmp : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabinetTmp : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ambientTmp : 1    10
    Should Contain X Times    ${refrig_Cryo3_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanSpeed : 1    10
    ${refrig_Cryo2_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2 start of topic ===
    ${refrig_Cryo2_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo2 end of topic ===
    ${refrig_Cryo2_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo2_start}    end=${refrig_Cryo2_end}
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgPrs : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctionPrs : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilLevel : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVoltage : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compCurrent : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compPower : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterInTmp : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterOutTmp : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}afterCoolTmp : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}phaseSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}surgeTankTmp : 1    10
    Should Contain X Times    ${refrig_Cryo2_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanSpeed : 1    10
    ${refrig_Cryo1_start}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1 start of topic ===
    ${refrig_Cryo1_end}=    Get Index From List    ${full_list}    === MTCamera_refrig_Cryo1 end of topic ===
    ${refrig_Cryo1_list}=    Get Slice From List    ${full_list}    start=${refrig_Cryo1_start}    end=${refrig_Cryo1_end}
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgtmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischrgPrs : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_P : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctiontmp_M : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}suctionPrs : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilLevel : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compVoltage : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compCurrent : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compPower : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterInTmp : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}waterOutTmp : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}afterCoolTmp : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}phaseSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oilSepTmp : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}surgeTankTmp : 1    10
    Should Contain X Times    ${refrig_Cryo1_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fanSpeed : 1    10
    ${vacuum_IonPumps_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumps start of topic ===
    ${vacuum_IonPumps_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_IonPumps end of topic ===
    ${vacuum_IonPumps_list}=    Get Slice From List    ${full_list}    start=${vacuum_IonPumps_start}    end=${vacuum_IonPumps_end}
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip1_I : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip2_I : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip3_I : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip4_I : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip5_I : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip6_I : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip1_V : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip2_V : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip3_V : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip4_V : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip5_V : 1    10
    Should Contain X Times    ${vacuum_IonPumps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cip6_V : 1    10
    ${vacuum_TurboPump_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPump start of topic ===
    ${vacuum_TurboPump_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboPump end of topic ===
    ${vacuum_TurboPump_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboPump_start}    end=${vacuum_TurboPump_end}
    Should Contain X Times    ${vacuum_TurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboSpeed : 1    10
    Should Contain X Times    ${vacuum_TurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboCurrent : 1    10
    Should Contain X Times    ${vacuum_TurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboVoltage : 1    10
    Should Contain X Times    ${vacuum_TurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboPower : 1    10
    Should Contain X Times    ${vacuum_TurboPump_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboPumpTemp : 1    10
    ${vacuum_CryoVacGauge_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGauge start of topic ===
    ${vacuum_CryoVacGauge_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_CryoVacGauge end of topic ===
    ${vacuum_CryoVacGauge_list}=    Get Slice From List    ${full_list}    start=${vacuum_CryoVacGauge_start}    end=${vacuum_CryoVacGauge_end}
    Should Contain X Times    ${vacuum_CryoVacGauge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoVac : 1    10
    ${vacuum_TurboVacGauge_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacGauge start of topic ===
    ${vacuum_TurboVacGauge_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_TurboVacGauge end of topic ===
    ${vacuum_TurboVacGauge_list}=    Get Slice From List    ${full_list}    start=${vacuum_TurboVacGauge_start}    end=${vacuum_TurboVacGauge_end}
    Should Contain X Times    ${vacuum_TurboVacGauge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}turboVac : 1    10
    ${vacuum_ForelineVacGauge_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacGauge start of topic ===
    ${vacuum_ForelineVacGauge_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_ForelineVacGauge end of topic ===
    ${vacuum_ForelineVacGauge_list}=    Get Slice From List    ${full_list}    start=${vacuum_ForelineVacGauge_start}    end=${vacuum_ForelineVacGauge_end}
    Should Contain X Times    ${vacuum_ForelineVacGauge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}forelineVac : 1    10
    ${vacuum_Hex1VacGauge_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacGauge start of topic ===
    ${vacuum_Hex1VacGauge_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex1VacGauge end of topic ===
    ${vacuum_Hex1VacGauge_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex1VacGauge_start}    end=${vacuum_Hex1VacGauge_end}
    Should Contain X Times    ${vacuum_Hex1VacGauge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hex1Vac : 1    10
    ${vacuum_Hex2VacGauge_start}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacGauge start of topic ===
    ${vacuum_Hex2VacGauge_end}=    Get Index From List    ${full_list}    === MTCamera_vacuum_Hex2VacGauge end of topic ===
    ${vacuum_Hex2VacGauge_list}=    Get Slice From List    ${full_list}    start=${vacuum_Hex2VacGauge_start}    end=${vacuum_Hex2VacGauge_end}
    Should Contain X Times    ${vacuum_Hex2VacGauge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hex2Vac : 1    10
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === MTCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end}
    Should Contain X Times    ${daq_monitor_Store_list}    ${SPACE}${SPACE}${SPACE}${SPACE}capacity : 1    10
    Should Contain X Times    ${daq_monitor_Store_list}    ${SPACE}${SPACE}${SPACE}${SPACE}freeSpace : 1    10
    Should Contain X Times    ${daq_monitor_Store_list}    ${SPACE}${SPACE}${SPACE}${SPACE}freeFraction : 1    10
    ${focal_plane_Reb_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb start of topic ===
    ${focal_plane_Reb_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Reb end of topic ===
    ${focal_plane_Reb_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Reb_start}    end=${focal_plane_Reb_end}
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPI : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPI : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPI : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPI : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPI : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPI : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPI : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPI : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPI : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPI : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrPV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk0 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk0 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk0 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk0 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk0 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk0 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk0 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk0 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk0 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk0 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk1 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk1 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk1 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk1 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk1 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk1 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk1 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk1 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk1 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClk1 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG0 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG0 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG0 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG0 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG0 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG0 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG0 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG0 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG0 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG0 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG1 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG1 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG1 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG1 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG1 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG1 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG1 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG1 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG1 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rG1 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk0 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk0 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk0 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk0 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk0 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk0 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk0 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk0 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk0 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk0 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk1 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk1 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk1 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk1 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk1 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk1 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk1 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk1 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk1 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClk1 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_GDV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_GDV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_GDV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_GDV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_GDV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_GDV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_GDV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_GDV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_GDV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_GDV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODI : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODI : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODI : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODI : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODI : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODI : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODI : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODI : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODI : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODI : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_ODV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_OGV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_OGV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_OGV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_OGV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_OGV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_OGV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_OGV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_OGV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_OGV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_OGV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_RDV : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_RDV : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_RDV : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_RDV : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_RDV : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_RDV : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_RDV : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_RDV : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_RDV : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_RDV : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_Temp : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_Temp : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_Temp : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_Temp : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_Temp : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_Temp : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_Temp : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_Temp : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_Temp : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sw_Temp : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 9    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 0    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 1    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 2    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 3    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 4    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 5    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 6    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 7    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 8    1
    Should Contain X Times    ${focal_plane_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 9    1
    ${focal_plane_Ccd_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd start of topic ===
    ${focal_plane_Ccd_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Ccd end of topic ===
    ${focal_plane_Ccd_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Ccd_start}    end=${focal_plane_Ccd_end}
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 0    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 1    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 2    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 3    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 4    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 5    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 6    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 7    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 8    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 9    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 0    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 1    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 2    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 3    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 4    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 5    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 6    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 7    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 8    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 9    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 0    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 1    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 2    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 3    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 4    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 5    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 6    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 7    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 8    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 9    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 0    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 1    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 2    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 3    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 4    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 5    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 6    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 7    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 8    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 9    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 0    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 1    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 2    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 3    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 4    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 5    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 6    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 7    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 8    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 9    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 0    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 1    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 2    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 3    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 4    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 5    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 6    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 7    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 8    1
    Should Contain X Times    ${focal_plane_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 9    1
    ${focal_plane_Segment_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment start of topic ===
    ${focal_plane_Segment_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_Segment end of topic ===
    ${focal_plane_Segment_list}=    Get Slice From List    ${full_list}    start=${focal_plane_Segment_start}    end=${focal_plane_Segment_end}
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 0    1
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 1    1
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 2    1
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 3    1
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 4    1
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 5    1
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 6    1
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 7    1
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 8    1
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 9    1
    Should Contain X Times    ${focal_plane_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${focal_plane_RebTotalPower_start}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower start of topic ===
    ${focal_plane_RebTotalPower_end}=    Get Index From List    ${full_list}    === MTCamera_focal_plane_RebTotalPower end of topic ===
    ${focal_plane_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${focal_plane_RebTotalPower_start}    end=${focal_plane_RebTotalPower_end}
    Should Contain X Times    ${focal_plane_RebTotalPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebTotalPower : 1    10
