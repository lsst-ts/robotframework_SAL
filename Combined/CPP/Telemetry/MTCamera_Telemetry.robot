*** Settings ***
Documentation    MTCamera Telemetry communications tests.
Force Tags    cpp    
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
${timeout}    30s

*** Test Cases ***
Verify Component Publisher and Subscriber
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber

Start Subscriber
    [Tags]    functional
    Comment    Start Subscriber.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_subscriber    alias=Subscriber
    Log    ${output}
    Should Contain    "${output}"   "1"
    ${object}=    Get Process Object    Subscriber
    Log    ${object.stdout.peek()}
    ${string}=    Convert To String    ${object.stdout.peek()}
    Should Contain    ${string}    ===== MTCamera subscribers ready =====

Start Publisher
    [Tags]    functional
    Comment    Start Publisher.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_publisher
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_shutter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_shutter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_shutter start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::shutter_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_shutter end of topic ===
    Comment    ======= Verify ${subSystem}_prot test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_prot
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_prot start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::prot_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_prot end of topic ===
    Comment    ======= Verify ${subSystem}_filter test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_filter
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_filter start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::filter_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_filter end of topic ===
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_heartbeat start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::heartbeat_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_heartbeat end of topic ===
    Comment    ======= Verify ${subSystem}_was test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_was
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_was start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::was_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_was end of topic ===
    Comment    ======= Verify ${subSystem}_ccs test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_ccs
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_ccs start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::ccs_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_ccs end of topic ===
    Comment    ======= Verify ${subSystem}_clusterEncoder test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_clusterEncoder
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_clusterEncoder start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::clusterEncoder_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_clusterEncoder end of topic ===
    Comment    ======= Verify ${subSystem}_cyro test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cyro
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_cyro start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::cyro_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_cyro end of topic ===
    Comment    ======= Verify ${subSystem}_purge test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_purge
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_purge start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::purge_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_purge end of topic ===
    Comment    ======= Verify ${subSystem}_wds test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_wds
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_wds start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::wds_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_wds end of topic ===
    Comment    ======= Verify ${subSystem}_gds test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_gds
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_gds start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::gds_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_gds end of topic ===
    Comment    ======= Verify ${subSystem}_sds test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_sds
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_sds start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::sds_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_sds end of topic ===
    Comment    ======= Verify ${subSystem}_gas test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_gas
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_gas start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::gas_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_gas end of topic ===
    Comment    ======= Verify ${subSystem}_pcms test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_pcms
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_pcms start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::pcms_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_pcms end of topic ===
    Comment    ======= Verify ${subSystem}_sas test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_sas
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_sas start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::sas_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_sas end of topic ===
    Comment    ======= Verify ${subSystem}_cold test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_cold
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain    ${output.stdout}    === MTCamera_cold start of topic ===
    Should Contain X Times    ${output.stdout}    [putSample] ${subSystem}::cold_${revcode} writing a message containing :    10
    Should Contain X Times    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === MTCamera_cold end of topic ===

Read Subscriber
    [Tags]    functional
    Switch Process    Subscriber
    ${output}=    Wait For Process    Subscriber    timeout=30    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    ===== MTCamera subscribers ready =====
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    ${shutter_start}=    Get Index From List    ${full_list}    === MTCamera_shutter start of topic ===
    ${shutter_end}=    Get Index From List    ${full_list}    === MTCamera_shutter end of topic ===
    ${shutter_list}=    Get Slice From List    ${full_list}    start=${shutter_start}    end=${shutter_end}
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 0    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 1    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 2    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 3    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 4    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 5    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 6    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 7    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 8    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bladeHome : 9    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 0    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 1    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 2    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 3    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 4    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 5    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 6    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 7    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 8    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}closeProfile : 9    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 0    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 1    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 2    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 3    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 4    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 5    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 6    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 7    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 8    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorCurrent : 9    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 0    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 1    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 2    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 3    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 4    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 5    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 6    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 7    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 8    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motorTemp : 9    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openDirection : 1    10
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 0    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 1    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 2    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 3    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 4    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 5    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 6    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 7    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 8    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openProfile : 9    1
    Should Contain X Times    ${shutter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}profileFunction : LSST    10
    ${prot_start}=    Get Index From List    ${full_list}    === MTCamera_prot start of topic ===
    ${prot_end}=    Get Index From List    ${full_list}    === MTCamera_prot end of topic ===
    ${prot_list}=    Get Slice From List    ${full_list}    start=${prot_start}    end=${prot_end}
    Should Contain X Times    ${prot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 0    1
    Should Contain X Times    ${prot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${prot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 2    1
    Should Contain X Times    ${prot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 3    1
    Should Contain X Times    ${prot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 4    1
    Should Contain X Times    ${prot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 5    1
    Should Contain X Times    ${prot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 6    1
    Should Contain X Times    ${prot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 7    1
    Should Contain X Times    ${prot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 8    1
    Should Contain X Times    ${prot_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 9    1
    ${filter_start}=    Get Index From List    ${full_list}    === MTCamera_filter start of topic ===
    ${filter_end}=    Get Index From List    ${full_list}    === MTCamera_filter end of topic ===
    ${filter_list}=    Get Slice From List    ${full_list}    start=${filter_start}    end=${filter_end}
    Should Contain X Times    ${filter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loaderTelemetry : 1    10
    Should Contain X Times    ${filter_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebID : 1    10
    ${heartbeat_start}=    Get Index From List    ${full_list}    === MTCamera_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === MTCamera_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    10
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    10
    ${was_start}=    Get Index From List    ${full_list}    === MTCamera_was start of topic ===
    ${was_end}=    Get Index From List    ${full_list}    === MTCamera_was end of topic ===
    ${was_list}=    Get Slice From List    ${full_list}    start=${was_start}    end=${was_end}
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardID : 1    10
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 0    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 1    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 2    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 3    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 4    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 5    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 6    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 7    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 8    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 9    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 0    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 1    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 2    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 3    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 4    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 5    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 6    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 7    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 8    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 9    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 0    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 1    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 2    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 3    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 4    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 5    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 6    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 7    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 8    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 9    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 0    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 1    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 2    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 3    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 4    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 5    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 6    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 7    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 8    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 9    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdID : 1    10
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdtemp : 1    10
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 0    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 1    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 2    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 3    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 4    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 5    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 6    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 7    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 8    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 9    1
    Should Contain X Times    ${was_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebID : 1    10
    ${ccs_start}=    Get Index From List    ${full_list}    === MTCamera_ccs start of topic ===
    ${ccs_end}=    Get Index From List    ${full_list}    === MTCamera_ccs end of topic ===
    ${ccs_list}=    Get Slice From List    ${full_list}    start=${ccs_start}    end=${ccs_end}
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccsStatus : 0    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccsStatus : 1    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccsStatus : 2    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccsStatus : 3    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccsStatus : 4    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccsStatus : 5    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccsStatus : 6    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccsStatus : 7    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccsStatus : 8    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccsStatus : 9    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageStatus : 0    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageStatus : 1    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageStatus : 2    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageStatus : 3    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageStatus : 4    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageStatus : 5    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageStatus : 6    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageStatus : 7    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageStatus : 8    1
    Should Contain X Times    ${ccs_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageStatus : 9    1
    ${clusterEncoder_start}=    Get Index From List    ${full_list}    === MTCamera_clusterEncoder start of topic ===
    ${clusterEncoder_end}=    Get Index From List    ${full_list}    === MTCamera_clusterEncoder end of topic ===
    ${clusterEncoder_list}=    Get Slice From List    ${full_list}    start=${clusterEncoder_start}    end=${clusterEncoder_end}
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 0    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 1    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 2    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 3    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 4    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 5    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 6    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 7    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 8    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageSD : 9    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 0    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 1    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 2    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 3    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 4    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 5    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 6    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 7    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 8    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}imageMean : 9    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 0    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 1    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 2    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 3    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 4    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 5    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 6    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 7    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 8    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanSD : 9    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 0    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 1    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 2    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 3    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 4    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 5    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 6    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 7    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 8    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overscanMean : 9    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 0    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 1    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 2    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 3    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 4    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 5    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 6    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 7    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 8    1
    Should Contain X Times    ${clusterEncoder_list}    ${SPACE}${SPACE}${SPACE}${SPACE}psf : 9    1
    ${cyro_start}=    Get Index From List    ${full_list}    === MTCamera_cyro start of topic ===
    ${cyro_end}=    Get Index From List    ${full_list}    === MTCamera_cyro end of topic ===
    ${cyro_list}=    Get Slice From List    ${full_list}    start=${cyro_start}    end=${cyro_end}
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coldTemperature : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressor : 1    10
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cryoTemperature : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 9    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 0    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 1    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 2    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 3    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 4    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 5    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 6    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 7    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 8    1
    Should Contain X Times    ${cyro_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 9    1
    ${purge_start}=    Get Index From List    ${full_list}    === MTCamera_purge start of topic ===
    ${purge_end}=    Get Index From List    ${full_list}    === MTCamera_purge end of topic ===
    ${purge_list}=    Get Slice From List    ${full_list}    start=${purge_start}    end=${purge_end}
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 0    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 1    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 2    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 3    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 4    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 5    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 6    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 7    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 8    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerometer : 9    1
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}blowerSetting : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}blowerSpeed : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bodyFlowMeter : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bodyTemp : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaters : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}microphone : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trunkFlowMeter : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trunkTemp : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveSetting : 1    10
    Should Contain X Times    ${purge_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valves : 1    10
    ${wds_start}=    Get Index From List    ${full_list}    === MTCamera_wds start of topic ===
    ${wds_end}=    Get Index From List    ${full_list}    === MTCamera_wds end of topic ===
    ${wds_list}=    Get Slice From List    ${full_list}    start=${wds_start}    end=${wds_end}
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebID : 1    10
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 0    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 1    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 2    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 3    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 4    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 5    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 6    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 7    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 8    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 9    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 0    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 1    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 2    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 3    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 4    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 5    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 6    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 7    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 8    1
    Should Contain X Times    ${wds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 9    1
    ${gds_start}=    Get Index From List    ${full_list}    === MTCamera_gds start of topic ===
    ${gds_end}=    Get Index From List    ${full_list}    === MTCamera_gds end of topic ===
    ${gds_list}=    Get Slice From List    ${full_list}    start=${gds_start}    end=${gds_end}
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebID : 1    10
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 0    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 1    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 2    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 3    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 4    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 5    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 6    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 7    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 8    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 9    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 0    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 1    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 2    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 3    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 4    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 5    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 6    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 7    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 8    1
    Should Contain X Times    ${gds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 9    1
    ${sds_start}=    Get Index From List    ${full_list}    === MTCamera_sds start of topic ===
    ${sds_end}=    Get Index From List    ${full_list}    === MTCamera_sds end of topic ===
    ${sds_list}=    Get Slice From List    ${full_list}    start=${sds_start}    end=${sds_end}
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebID : 1    10
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 0    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 1    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 2    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 3    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 4    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 5    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 6    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 7    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 8    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timingParameters : 9    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 0    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 1    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 2    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 3    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 4    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 5    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 6    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 7    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 8    1
    Should Contain X Times    ${sds_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flag : 9    1
    ${gas_start}=    Get Index From List    ${full_list}    === MTCamera_gas start of topic ===
    ${gas_end}=    Get Index From List    ${full_list}    === MTCamera_gas end of topic ===
    ${gas_list}=    Get Slice From List    ${full_list}    start=${gas_start}    end=${gas_end}
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardID : 1    10
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 0    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 1    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 2    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 3    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 4    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 5    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 6    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 7    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 8    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 9    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 0    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 1    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 2    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 3    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 4    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 5    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 6    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 7    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 8    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 9    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 0    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 1    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 2    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 3    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 4    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 5    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 6    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 7    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 8    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 9    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 0    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 1    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 2    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 3    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 4    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 5    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 6    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 7    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 8    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 9    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdID : 1    10
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdtemp : 1    10
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 0    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 1    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 2    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 3    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 4    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 5    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 6    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 7    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 8    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 9    1
    Should Contain X Times    ${gas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebID : 1    10
    ${pcms_start}=    Get Index From List    ${full_list}    === MTCamera_pcms start of topic ===
    ${pcms_end}=    Get Index From List    ${full_list}    === MTCamera_pcms end of topic ===
    ${pcms_list}=    Get Slice From List    ${full_list}    start=${pcms_start}    end=${pcms_end}
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}biasStatus : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}biasCurrent : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}biasVoltage : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockStatus : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockCurrent : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}clockVoltage : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaStatus : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCurrent : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaVoltage : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowStatus : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowCurrent : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lowVoltage : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odStatus : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odCurrent : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}odVoltage : 1    10
    Should Contain X Times    ${pcms_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebID : 1    10
    ${sas_start}=    Get Index From List    ${full_list}    === MTCamera_sas start of topic ===
    ${sas_end}=    Get Index From List    ${full_list}    === MTCamera_sas end of topic ===
    ${sas_list}=    Get Slice From List    ${full_list}    start=${sas_start}    end=${sas_end}
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardID : 1    10
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 0    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 1    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 2    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 3    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 4    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 5    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 6    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 7    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 8    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardCurrent : 9    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 0    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 1    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 2    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 3    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 4    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 5    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 6    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 7    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 8    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardTemp : 9    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 0    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 1    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 2    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 3    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 4    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 5    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 6    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 7    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 8    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}boardVoltage : 9    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 0    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 1    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 2    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 3    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 4    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 5    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 6    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 7    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 8    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cabacMUX : 9    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdID : 1    10
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ccdtemp : 1    10
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 0    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 1    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 2    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 3    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 4    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 5    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 6    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 7    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 8    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}fpgaCheckSum : 9    1
    Should Contain X Times    ${sas_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rebID : 1    10
    ${cold_start}=    Get Index From List    ${full_list}    === MTCamera_cold start of topic ===
    ${cold_end}=    Get Index From List    ${full_list}    === MTCamera_cold end of topic ===
    ${cold_list}=    Get Slice From List    ${full_list}    start=${cold_start}    end=${cold_end}
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorLoad : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}compressorSpeed : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargePressure : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dischargeTemp : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}flowInterlock : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterCurrent : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heaterVoltage : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeFlow : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakePressure : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intakeTemp : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ionPump : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mechPump : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionPressure : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}postExpansionTemp : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionPressure : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}preExpansionTemp : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rga : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}returnTemp : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}utilityRoomTemperature : 1    10
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}vacuumGauge : 9    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 0    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 1    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 2    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 3    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 4    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 5    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 6    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 7    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 8    1
    Should Contain X Times    ${cold_list}    ${SPACE}${SPACE}${SPACE}${SPACE}valveStatus : 9    1
