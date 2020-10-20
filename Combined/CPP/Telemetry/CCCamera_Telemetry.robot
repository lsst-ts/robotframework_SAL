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
    Comment    ======= Verify ${subSystem}_rebpower_Reb test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_rebpower_Reb
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_rebpower_Reb start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::rebpower_Reb_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_rebpower_Reb end of topic ===
    Comment    ======= Verify ${subSystem}_rebpower_Rebps test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_rebpower_Rebps
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_rebpower_Rebps start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::rebpower_Rebps_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_rebpower_Rebps end of topic ===
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
    Comment    ======= Verify ${subSystem}_vacuum_Rtds test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_vacuum_Rtds
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_vacuum_Rtds start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::vacuum_Rtds_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_vacuum_Rtds end of topic ===
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
    Comment    ======= Verify ${subSystem}_daq_monitor_Store test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_daq_monitor_Store
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_daq_monitor_Store start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::daq_monitor_Store_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_daq_monitor_Store end of topic ===
    Comment    ======= Verify ${subSystem}_fp_Reb test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_fp_Reb
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_fp_Reb start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::fp_Reb_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_fp_Reb end of topic ===
    Comment    ======= Verify ${subSystem}_fp_Ccd test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_fp_Ccd
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_fp_Ccd start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::fp_Ccd_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_fp_Ccd end of topic ===
    Comment    ======= Verify ${subSystem}_fp_Segment test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_fp_Segment
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_fp_Segment start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::fp_Segment_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_fp_Segment end of topic ===
    Comment    ======= Verify ${subSystem}_fp_RebTotalPower test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_fp_RebTotalPower
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain    ${output.stdout}    === CCCamera_fp_RebTotalPower start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::fp_RebTotalPower_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === CCCamera_fp_RebTotalPower end of topic ===

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
    ${rebpower_Reb_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb start of topic ===
    ${rebpower_Reb_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Reb end of topic ===
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
    ${rebpower_Rebps_start}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps start of topic ===
    ${rebpower_Rebps_end}=    Get Index From List    ${full_list}    === CCCamera_rebpower_Rebps end of topic ===
    ${rebpower_Rebps_list}=    Get Slice From List    ${full_list}    start=${rebpower_Rebps_start}    end=${rebpower_Rebps_end}
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp0 : 1    10
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp1 : 1    10
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp2 : 1    10
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp3 : 1    10
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp4 : 1    10
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp5 : 1    10
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp6 : 1    10
    Should Contain X Times    ${rebpower_Rebps_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
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
    ${vacuum_Rtds_start}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds start of topic ===
    ${vacuum_Rtds_end}=    Get Index From List    ${full_list}    === CCCamera_vacuum_Rtds end of topic ===
    ${vacuum_Rtds_list}=    Get Slice From List    ${full_list}    start=${vacuum_Rtds_start}    end=${vacuum_Rtds_end}
    Should Contain X Times    ${vacuum_Rtds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureCold1 : 1    10
    Should Contain X Times    ${vacuum_Rtds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureCold2 : 1    10
    Should Contain X Times    ${vacuum_Rtds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temperatureCryo : 1    10
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
    ${daq_monitor_Store_start}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store start of topic ===
    ${daq_monitor_Store_end}=    Get Index From List    ${full_list}    === CCCamera_daq_monitor_Store end of topic ===
    ${daq_monitor_Store_list}=    Get Slice From List    ${full_list}    start=${daq_monitor_Store_start}    end=${daq_monitor_Store_end}
    Should Contain X Times    ${daq_monitor_Store_list}    ${SPACE}${SPACE}${SPACE}${SPACE}capacity : 1    10
    Should Contain X Times    ${daq_monitor_Store_list}    ${SPACE}${SPACE}${SPACE}${SPACE}freeSpace : 1    10
    Should Contain X Times    ${daq_monitor_Store_list}    ${SPACE}${SPACE}${SPACE}${SPACE}freeFraction : 1    10
    ${fp_Reb_start}=    Get Index From List    ${full_list}    === CCCamera_fp_Reb start of topic ===
    ${fp_Reb_end}=    Get Index From List    ${full_list}    === CCCamera_fp_Reb end of topic ===
    ${fp_Reb_list}=    Get Slice From List    ${full_list}    start=${fp_Reb_start}    end=${fp_Reb_end}
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaI : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}anaV : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp0 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp1 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicl_Temp2 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp0 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp1 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}aspicu_Temp2 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHI : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkHV : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLI : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clkLV : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digI : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}digV : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrV : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}htrW : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hVBiasSwitch : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDI : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkL : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pClkU : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}power : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref05V : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref125V : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref15V : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ref25V : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refN12 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}refP12 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGL : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rGU : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rTDTemp : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkL : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}sClkU : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp1 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp10 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp2 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp3 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp4 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp5 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp6 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp7 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp8 : 9    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 0    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 1    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 2    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 3    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 4    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 5    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 6    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 7    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 8    1
    Should Contain X Times    ${fp_Reb_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp9 : 9    1
    ${fp_Ccd_start}=    Get Index From List    ${full_list}    === CCCamera_fp_Ccd start of topic ===
    ${fp_Ccd_end}=    Get Index From List    ${full_list}    === CCCamera_fp_Ccd end of topic ===
    ${fp_Ccd_list}=    Get Slice From List    ${full_list}    start=${fp_Ccd_start}    end=${fp_Ccd_end}
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 0    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 1    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 2    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 3    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 4    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 5    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 6    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 7    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 8    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gDV : 9    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 0    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 1    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 2    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 3    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 4    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 5    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 6    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 7    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 8    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oDV : 9    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 0    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 1    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 2    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 3    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 4    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 5    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 6    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 7    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 8    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}oGV : 9    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 0    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 1    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 2    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 3    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 4    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 5    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 6    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 7    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 8    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rDV : 9    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 0    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 1    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 2    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 3    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 4    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 5    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 6    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 7    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 8    1
    Should Contain X Times    ${fp_Ccd_list}    ${SPACE}${SPACE}${SPACE}${SPACE}temp : 9    1
    ${fp_Segment_start}=    Get Index From List    ${full_list}    === CCCamera_fp_Segment start of topic ===
    ${fp_Segment_end}=    Get Index From List    ${full_list}    === CCCamera_fp_Segment end of topic ===
    ${fp_Segment_list}=    Get Slice From List    ${full_list}    start=${fp_Segment_start}    end=${fp_Segment_end}
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 0    1
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 1    1
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 2    1
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 3    1
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 4    1
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 5    1
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 6    1
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 7    1
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 8    1
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}i : 9    1
    Should Contain X Times    ${fp_Segment_list}    ${SPACE}${SPACE}${SPACE}${SPACE}location : RO    10
    ${fp_RebTotalPower_start}=    Get Index From List    ${full_list}    === CCCamera_fp_RebTotalPower start of topic ===
    ${fp_RebTotalPower_end}=    Get Index From List    ${full_list}    === CCCamera_fp_RebTotalPower end of topic ===
    ${fp_RebTotalPower_list}=    Get Slice From List    ${full_list}    start=${fp_RebTotalPower_start}    end=${fp_RebTotalPower_end}
    Should Contain X Times    ${fp_RebTotalPower_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebTotalPower : 1    10
