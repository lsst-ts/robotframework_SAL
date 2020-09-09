*** Settings ***
Documentation    MTM2_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTM2
${component}    all
${timeout}    45s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    Comment    Wait to allow full output to be written to file.
    Sleep    5s
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_m2AssemblyInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2AssemblyInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2AssemblyInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2AssemblyInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2AssemblyInPosition generated =
    Comment    ======= Verify ${subSystem}_cellTemperatureHiWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_cellTemperatureHiWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event cellTemperatureHiWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_cellTemperatureHiWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event cellTemperatureHiWarning generated =
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_commandableByDDS test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_commandableByDDS
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event commandableByDDS iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_commandableByDDS_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event commandableByDDS generated =
    Comment    ======= Verify ${subSystem}_interlock test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_interlock
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event interlock iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_interlock_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event interlock generated =
    Comment    ======= Verify ${subSystem}_tcpIpConnected test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_tcpIpConnected
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event tcpIpConnected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_tcpIpConnected_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event tcpIpConnected generated =
    Comment    ======= Verify ${subSystem}_hardpointList test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hardpointList
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hardpointList iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hardpointList_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hardpointList generated =
    Comment    ======= Verify ${subSystem}_forceBalanceSystemStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_forceBalanceSystemStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event forceBalanceSystemStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_forceBalanceSystemStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event forceBalanceSystemStatus generated =
    Comment    ======= Verify ${subSystem}_inclinationTelemetrySource test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inclinationTelemetrySource
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event inclinationTelemetrySource iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inclinationTelemetrySource_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inclinationTelemetrySource generated =
    Comment    ======= Verify ${subSystem}_temperatureOffset test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_temperatureOffset
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event temperatureOffset iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_temperatureOffset_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event temperatureOffset generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${m2AssemblyInPosition_start}=    Get Index From List    ${full_list}    === Event m2AssemblyInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m2AssemblyInPosition_start}
    ${m2AssemblyInPosition_end}=    Evaluate    ${end}+${1}
    ${m2AssemblyInPosition_list}=    Get Slice From List    ${full_list}    start=${m2AssemblyInPosition_start}    end=${m2AssemblyInPosition_end}
    Should Contain X Times    ${m2AssemblyInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${m2AssemblyInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${cellTemperatureHiWarning_start}=    Get Index From List    ${full_list}    === Event cellTemperatureHiWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${cellTemperatureHiWarning_start}
    ${cellTemperatureHiWarning_end}=    Evaluate    ${end}+${1}
    ${cellTemperatureHiWarning_list}=    Get Slice From List    ${full_list}    start=${cellTemperatureHiWarning_start}    end=${cellTemperatureHiWarning_end}
    Should Contain X Times    ${cellTemperatureHiWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hiWarning : 1    1
    Should Contain X Times    ${cellTemperatureHiWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${detailedState_start}
    ${detailedState_end}=    Evaluate    ${end}+${1}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${commandableByDDS_start}=    Get Index From List    ${full_list}    === Event commandableByDDS received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${commandableByDDS_start}
    ${commandableByDDS_end}=    Evaluate    ${end}+${1}
    ${commandableByDDS_list}=    Get Slice From List    ${full_list}    start=${commandableByDDS_start}    end=${commandableByDDS_end}
    Should Contain X Times    ${commandableByDDS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${commandableByDDS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${interlock_start}=    Get Index From List    ${full_list}    === Event interlock received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${interlock_start}
    ${interlock_end}=    Evaluate    ${end}+${1}
    ${interlock_list}=    Get Slice From List    ${full_list}    start=${interlock_start}    end=${interlock_end}
    Should Contain X Times    ${interlock_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    Should Contain X Times    ${interlock_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${tcpIpConnected_start}=    Get Index From List    ${full_list}    === Event tcpIpConnected received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${tcpIpConnected_start}
    ${tcpIpConnected_end}=    Evaluate    ${end}+${1}
    ${tcpIpConnected_list}=    Get Slice From List    ${full_list}    start=${tcpIpConnected_start}    end=${tcpIpConnected_end}
    Should Contain X Times    ${tcpIpConnected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}isConnected : 1    1
    Should Contain X Times    ${tcpIpConnected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hardpointList_start}=    Get Index From List    ${full_list}    === Event hardpointList received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${hardpointList_start}
    ${hardpointList_end}=    Evaluate    ${end}+${1}
    ${hardpointList_list}=    Get Slice From List    ${full_list}    start=${hardpointList_start}    end=${hardpointList_end}
    Should Contain X Times    ${hardpointList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}actuators : 0    1
    Should Contain X Times    ${hardpointList_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${forceBalanceSystemStatus_start}=    Get Index From List    ${full_list}    === Event forceBalanceSystemStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${forceBalanceSystemStatus_start}
    ${forceBalanceSystemStatus_end}=    Evaluate    ${end}+${1}
    ${forceBalanceSystemStatus_list}=    Get Slice From List    ${full_list}    start=${forceBalanceSystemStatus_start}    end=${forceBalanceSystemStatus_end}
    Should Contain X Times    ${forceBalanceSystemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${forceBalanceSystemStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inclinationTelemetrySource_start}=    Get Index From List    ${full_list}    === Event inclinationTelemetrySource received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inclinationTelemetrySource_start}
    ${inclinationTelemetrySource_end}=    Evaluate    ${end}+${1}
    ${inclinationTelemetrySource_list}=    Get Slice From List    ${full_list}    start=${inclinationTelemetrySource_start}    end=${inclinationTelemetrySource_end}
    Should Contain X Times    ${inclinationTelemetrySource_list}    ${SPACE}${SPACE}${SPACE}${SPACE}source : 1    1
    Should Contain X Times    ${inclinationTelemetrySource_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${temperatureOffset_start}=    Get Index From List    ${full_list}    === Event temperatureOffset received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${temperatureOffset_start}
    ${temperatureOffset_end}=    Evaluate    ${end}+${1}
    ${temperatureOffset_list}=    Get Slice From List    ${full_list}    start=${temperatureOffset_start}    end=${temperatureOffset_end}
    Should Contain X Times    ${temperatureOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ring : 0    1
    Should Contain X Times    ${temperatureOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intake : 0    1
    Should Contain X Times    ${temperatureOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}exhaust : 0    1
    Should Contain X Times    ${temperatureOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
