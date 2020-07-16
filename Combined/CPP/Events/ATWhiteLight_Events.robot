*** Settings ***
Documentation    ATWhiteLight_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATWhiteLight
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
    Comment    Wait 3s to allow full output to be written to file.
    Sleep    3s
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_loopTimeOutOfRange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_loopTimeOutOfRange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event loopTimeOutOfRange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_loopTimeOutOfRange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event loopTimeOutOfRange generated =
    Comment    ======= Verify ${subSystem}_rejectedCommand test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedCommand
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedCommand iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedCommand_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedCommand generated =
    Comment    ======= Verify ${subSystem}_whiteLightStatus test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_whiteLightStatus
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event whiteLightStatus iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_whiteLightStatus_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event whiteLightStatus generated =
    Comment    ======= Verify ${subSystem}_chillerLowFlowWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_chillerLowFlowWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event chillerLowFlowWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_chillerLowFlowWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event chillerLowFlowWarning generated =
    Comment    ======= Verify ${subSystem}_chillerFluidLevelWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_chillerFluidLevelWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event chillerFluidLevelWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_chillerFluidLevelWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event chillerFluidLevelWarning generated =
    Comment    ======= Verify ${subSystem}_chillerSwitchToSupplyTempWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_chillerSwitchToSupplyTempWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event chillerSwitchToSupplyTempWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_chillerSwitchToSupplyTempWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event chillerSwitchToSupplyTempWarning generated =
    Comment    ======= Verify ${subSystem}_chillerHighControlTempWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_chillerHighControlTempWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event chillerHighControlTempWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_chillerHighControlTempWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event chillerHighControlTempWarning generated =
    Comment    ======= Verify ${subSystem}_chillerLowControlTempWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_chillerLowControlTempWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event chillerLowControlTempWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_chillerLowControlTempWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event chillerLowControlTempWarning generated =
    Comment    ======= Verify ${subSystem}_chillerHighAmbientTempWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_chillerHighAmbientTempWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event chillerHighAmbientTempWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_chillerHighAmbientTempWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event chillerHighAmbientTempWarning generated =
    Comment    ======= Verify ${subSystem}_chillerLowAmbientTempWarning test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_chillerLowAmbientTempWarning
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event chillerLowAmbientTempWarning iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_chillerLowAmbientTempWarning_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event chillerLowAmbientTempWarning generated =
    Comment    ======= Verify ${subSystem}_chillerTempReached test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_chillerTempReached
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event chillerTempReached iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_chillerTempReached_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event chillerTempReached generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${loopTimeOutOfRange_start}=    Get Index From List    ${full_list}    === Event loopTimeOutOfRange received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${loopTimeOutOfRange_start}
    ${loopTimeOutOfRange_end}=    Evaluate    ${end}+${1}
    ${loopTimeOutOfRange_list}=    Get Slice From List    ${full_list}    start=${loopTimeOutOfRange_start}    end=${loopTimeOutOfRange_end}
    Should Contain X Times    ${loopTimeOutOfRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loopTimeOutOfRange : 1    1
    Should Contain X Times    ${loopTimeOutOfRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedCommand_start}=    Get Index From List    ${full_list}    === Event rejectedCommand received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rejectedCommand_start}
    ${rejectedCommand_end}=    Evaluate    ${end}+${1}
    ${rejectedCommand_list}=    Get Slice From List    ${full_list}    start=${rejectedCommand_start}    end=${rejectedCommand_end}
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandValue : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${whiteLightStatus_start}=    Get Index From List    ${full_list}    === Event whiteLightStatus received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${whiteLightStatus_start}
    ${whiteLightStatus_end}=    Evaluate    ${end}+${1}
    ${whiteLightStatus_list}=    Get Slice From List    ${full_list}    start=${whiteLightStatus_start}    end=${whiteLightStatus_end}
    Should Contain X Times    ${whiteLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wattageChange : 1    1
    Should Contain X Times    ${whiteLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}coolingDown : 1    1
    Should Contain X Times    ${whiteLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}error : 1    1
    Should Contain X Times    ${whiteLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}acceptingCommands : 1    1
    Should Contain X Times    ${whiteLightStatus_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${chillerLowFlowWarning_start}=    Get Index From List    ${full_list}    === Event chillerLowFlowWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${chillerLowFlowWarning_start}
    ${chillerLowFlowWarning_end}=    Evaluate    ${end}+${1}
    ${chillerLowFlowWarning_list}=    Get Slice From List    ${full_list}    start=${chillerLowFlowWarning_start}    end=${chillerLowFlowWarning_end}
    Should Contain X Times    ${chillerLowFlowWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warning : 1    1
    Should Contain X Times    ${chillerLowFlowWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${chillerLowFlowWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${chillerFluidLevelWarning_start}=    Get Index From List    ${full_list}    === Event chillerFluidLevelWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${chillerFluidLevelWarning_start}
    ${chillerFluidLevelWarning_end}=    Evaluate    ${end}+${1}
    ${chillerFluidLevelWarning_list}=    Get Slice From List    ${full_list}    start=${chillerFluidLevelWarning_start}    end=${chillerFluidLevelWarning_end}
    Should Contain X Times    ${chillerFluidLevelWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warning : 1    1
    Should Contain X Times    ${chillerFluidLevelWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${chillerFluidLevelWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${chillerSwitchToSupplyTempWarning_start}=    Get Index From List    ${full_list}    === Event chillerSwitchToSupplyTempWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${chillerSwitchToSupplyTempWarning_start}
    ${chillerSwitchToSupplyTempWarning_end}=    Evaluate    ${end}+${1}
    ${chillerSwitchToSupplyTempWarning_list}=    Get Slice From List    ${full_list}    start=${chillerSwitchToSupplyTempWarning_start}    end=${chillerSwitchToSupplyTempWarning_end}
    Should Contain X Times    ${chillerSwitchToSupplyTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warning : 1    1
    Should Contain X Times    ${chillerSwitchToSupplyTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${chillerSwitchToSupplyTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${chillerHighControlTempWarning_start}=    Get Index From List    ${full_list}    === Event chillerHighControlTempWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${chillerHighControlTempWarning_start}
    ${chillerHighControlTempWarning_end}=    Evaluate    ${end}+${1}
    ${chillerHighControlTempWarning_list}=    Get Slice From List    ${full_list}    start=${chillerHighControlTempWarning_start}    end=${chillerHighControlTempWarning_end}
    Should Contain X Times    ${chillerHighControlTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warning : 1    1
    Should Contain X Times    ${chillerHighControlTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${chillerHighControlTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${chillerLowControlTempWarning_start}=    Get Index From List    ${full_list}    === Event chillerLowControlTempWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${chillerLowControlTempWarning_start}
    ${chillerLowControlTempWarning_end}=    Evaluate    ${end}+${1}
    ${chillerLowControlTempWarning_list}=    Get Slice From List    ${full_list}    start=${chillerLowControlTempWarning_start}    end=${chillerLowControlTempWarning_end}
    Should Contain X Times    ${chillerLowControlTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warning : 1    1
    Should Contain X Times    ${chillerLowControlTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${chillerLowControlTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${chillerHighAmbientTempWarning_start}=    Get Index From List    ${full_list}    === Event chillerHighAmbientTempWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${chillerHighAmbientTempWarning_start}
    ${chillerHighAmbientTempWarning_end}=    Evaluate    ${end}+${1}
    ${chillerHighAmbientTempWarning_list}=    Get Slice From List    ${full_list}    start=${chillerHighAmbientTempWarning_start}    end=${chillerHighAmbientTempWarning_end}
    Should Contain X Times    ${chillerHighAmbientTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warning : 1    1
    Should Contain X Times    ${chillerHighAmbientTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${chillerHighAmbientTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${chillerLowAmbientTempWarning_start}=    Get Index From List    ${full_list}    === Event chillerLowAmbientTempWarning received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${chillerLowAmbientTempWarning_start}
    ${chillerLowAmbientTempWarning_end}=    Evaluate    ${end}+${1}
    ${chillerLowAmbientTempWarning_list}=    Get Slice From List    ${full_list}    start=${chillerLowAmbientTempWarning_start}    end=${chillerLowAmbientTempWarning_end}
    Should Contain X Times    ${chillerLowAmbientTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}warning : 1    1
    Should Contain X Times    ${chillerLowAmbientTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${chillerLowAmbientTempWarning_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${chillerTempReached_start}=    Get Index From List    ${full_list}    === Event chillerTempReached received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${chillerTempReached_start}
    ${chillerTempReached_end}=    Evaluate    ${end}+${1}
    ${chillerTempReached_list}=    Get Slice From List    ${full_list}    start=${chillerTempReached_start}    end=${chillerTempReached_end}
    Should Contain X Times    ${chillerTempReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inTemperature : 1    1
    Should Contain X Times    ${chillerTempReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${chillerTempReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
