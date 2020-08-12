*** Settings ***
Documentation    ATMonochromator_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATMonochromator
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
    Comment    ======= Verify ${subSystem}_internalCommand test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_internalCommand
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event internalCommand iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_internalCommand_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event internalCommand generated =
    Comment    ======= Verify ${subSystem}_loopTimeOutOfRange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_loopTimeOutOfRange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event loopTimeOutOfRange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_loopTimeOutOfRange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event loopTimeOutOfRange generated =
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_status test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_status
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event status iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_status_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event status generated =
    Comment    ======= Verify ${subSystem}_rejectedCommand test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedCommand
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedCommand iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedCommand_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedCommand generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedMonoCommunication test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedMonoCommunication
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedMonoCommunication iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedMonoCommunication_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedMonoCommunication generated =
    Comment    ======= Verify ${subSystem}_selectedGrating test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_selectedGrating
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event selectedGrating iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_selectedGrating_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event selectedGrating generated =
    Comment    ======= Verify ${subSystem}_wavelength test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_wavelength
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event wavelength iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_wavelength_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event wavelength generated =
    Comment    ======= Verify ${subSystem}_slitWidth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_slitWidth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event slitWidth iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_slitWidth_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event slitWidth generated =
    Comment    ======= Verify ${subSystem}_entrySlitWidth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_entrySlitWidth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event entrySlitWidth iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_entrySlitWidth_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event entrySlitWidth generated =
    Comment    ======= Verify ${subSystem}_exitSlitWidth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_exitSlitWidth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event exitSlitWidth iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_exitSlitWidth_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event exitSlitWidth generated =
    Comment    ======= Verify ${subSystem}_inPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPosition generated =
    Comment    ======= Verify ${subSystem}_monochromatorConnected test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_monochromatorConnected
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event monochromatorConnected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_monochromatorConnected_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event monochromatorConnected generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedMonoHeartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedMonoHeartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedMonoHeartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedMonoHeartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedMonoHeartbeat generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedLoop test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedLoop
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedLoop iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedLoop_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedLoop generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedMonochromatorRanges test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedMonochromatorRanges
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedMonochromatorRanges iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedMonochromatorRanges_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedMonochromatorRanges generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${internalCommand_start}=    Get Index From List    ${full_list}    === Event internalCommand received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${internalCommand_start}
    ${internalCommand_end}=    Evaluate    ${end}+${1}
    ${internalCommand_list}=    Get Slice From List    ${full_list}    start=${internalCommand_start}    end=${internalCommand_end}
    Should Contain X Times    ${internalCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandObject : \x00    1
    Should Contain X Times    ${internalCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${loopTimeOutOfRange_start}=    Get Index From List    ${full_list}    === Event loopTimeOutOfRange received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${loopTimeOutOfRange_start}
    ${loopTimeOutOfRange_end}=    Evaluate    ${end}+${1}
    ${loopTimeOutOfRange_list}=    Get Slice From List    ${full_list}    start=${loopTimeOutOfRange_start}    end=${loopTimeOutOfRange_end}
    Should Contain X Times    ${loopTimeOutOfRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loopTimeOutOfRange : 1    1
    Should Contain X Times    ${loopTimeOutOfRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${detailedState_start}
    ${detailedState_end}=    Evaluate    ${end}+${1}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${status_start}=    Get Index From List    ${full_list}    === Event status received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${status_start}
    ${status_end}=    Evaluate    ${end}+${1}
    ${status_list}=    Get Slice From List    ${full_list}    start=${status_start}    end=${status_end}
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${status_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedCommand_start}=    Get Index From List    ${full_list}    === Event rejectedCommand received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rejectedCommand_start}
    ${rejectedCommand_end}=    Evaluate    ${end}+${1}
    ${rejectedCommand_list}=    Get Slice From List    ${full_list}    start=${rejectedCommand_start}    end=${rejectedCommand_end}
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandValue : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedMonoCommunication_start}=    Get Index From List    ${full_list}    === Event settingsAppliedMonoCommunication received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedMonoCommunication_start}
    ${settingsAppliedMonoCommunication_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedMonoCommunication_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedMonoCommunication_start}    end=${settingsAppliedMonoCommunication_end}
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ip : RO    1
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}portRange : 1    1
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readTimeout : 1    1
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}writeTimeout : 1    1
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}connectionTimeout : 1    1
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${selectedGrating_start}=    Get Index From List    ${full_list}    === Event selectedGrating received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${selectedGrating_start}
    ${selectedGrating_end}=    Evaluate    ${end}+${1}
    ${selectedGrating_list}=    Get Slice From List    ${full_list}    start=${selectedGrating_start}    end=${selectedGrating_end}
    Should Contain X Times    ${selectedGrating_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gratingType : 1    1
    Should Contain X Times    ${selectedGrating_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${selectedGrating_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${wavelength_start}=    Get Index From List    ${full_list}    === Event wavelength received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${wavelength_start}
    ${wavelength_end}=    Evaluate    ${end}+${1}
    ${wavelength_list}=    Get Slice From List    ${full_list}    start=${wavelength_start}    end=${wavelength_end}
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelength : 1    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${slitWidth_start}=    Get Index From List    ${full_list}    === Event slitWidth received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${slitWidth_start}
    ${slitWidth_end}=    Evaluate    ${end}+${1}
    ${slitWidth_list}=    Get Slice From List    ${full_list}    start=${slitWidth_start}    end=${slitWidth_end}
    Should Contain X Times    ${slitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slit : 1    1
    Should Contain X Times    ${slitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slitPosition : 1    1
    Should Contain X Times    ${slitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${slitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${entrySlitWidth_start}=    Get Index From List    ${full_list}    === Event entrySlitWidth received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${entrySlitWidth_start}
    ${entrySlitWidth_end}=    Evaluate    ${end}+${1}
    ${entrySlitWidth_list}=    Get Slice From List    ${full_list}    start=${entrySlitWidth_start}    end=${entrySlitWidth_end}
    Should Contain X Times    ${entrySlitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}width : 1    1
    Should Contain X Times    ${entrySlitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${exitSlitWidth_start}=    Get Index From List    ${full_list}    === Event exitSlitWidth received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${exitSlitWidth_start}
    ${exitSlitWidth_end}=    Evaluate    ${end}+${1}
    ${exitSlitWidth_list}=    Get Slice From List    ${full_list}    start=${exitSlitWidth_start}    end=${exitSlitWidth_end}
    Should Contain X Times    ${exitSlitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}width : 1    1
    Should Contain X Times    ${exitSlitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPosition_start}=    Get Index From List    ${full_list}    === Event inPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inPosition_start}
    ${inPosition_end}=    Evaluate    ${end}+${1}
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${inPosition_end}
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}device : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${monochromatorConnected_start}=    Get Index From List    ${full_list}    === Event monochromatorConnected received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${monochromatorConnected_start}
    ${monochromatorConnected_end}=    Evaluate    ${end}+${1}
    ${monochromatorConnected_list}=    Get Slice From List    ${full_list}    start=${monochromatorConnected_start}    end=${monochromatorConnected_end}
    Should Contain X Times    ${monochromatorConnected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}connected : 1    1
    Should Contain X Times    ${monochromatorConnected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedMonoHeartbeat_start}=    Get Index From List    ${full_list}    === Event settingsAppliedMonoHeartbeat received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedMonoHeartbeat_start}
    ${settingsAppliedMonoHeartbeat_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedMonoHeartbeat_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedMonoHeartbeat_start}    end=${settingsAppliedMonoHeartbeat_end}
    Should Contain X Times    ${settingsAppliedMonoHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}period : 1    1
    Should Contain X Times    ${settingsAppliedMonoHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout : 1    1
    Should Contain X Times    ${settingsAppliedMonoHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedLoop_start}=    Get Index From List    ${full_list}    === Event settingsAppliedLoop received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedLoop_start}
    ${settingsAppliedLoop_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedLoop_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedLoop_start}    end=${settingsAppliedLoop_end}
    Should Contain X Times    ${settingsAppliedLoop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}period : 1    1
    Should Contain X Times    ${settingsAppliedLoop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}periodAllowedJitter : 1    1
    Should Contain X Times    ${settingsAppliedLoop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedMonochromatorRanges_start}=    Get Index From List    ${full_list}    === Event settingsAppliedMonochromatorRanges received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedMonochromatorRanges_start}
    ${settingsAppliedMonochromatorRanges_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedMonochromatorRanges_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedMonochromatorRanges_start}    end=${settingsAppliedMonochromatorRanges_end}
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelengthGR1 : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelengthGR1_GR2 : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelengthGR2 : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minSlitWidth : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSlitWidth : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minWavelength : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxWavelength : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
