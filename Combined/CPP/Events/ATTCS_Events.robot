*** Settings ***
Documentation    ATTCS_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATTCS
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    === ${subSystem} loggers ready
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_spectrographInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_spectrographInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event spectrographInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_spectrographInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event spectrographInPosition generated =
    Comment    ======= Verify ${subSystem}_telescopeInPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_telescopeInPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event telescopeInPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_telescopeInPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event telescopeInPosition generated =
    Comment    ======= Verify ${subSystem}_rejectedCommand test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedCommand
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rejectedCommand iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedCommand_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rejectedCommand generated =
    Comment    ======= Verify ${subSystem}_internalCommand test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_internalCommand
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event internalCommand iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_internalCommand_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event internalCommand generated =
    Comment    ======= Verify ${subSystem}_loopTimeOutOfRange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_loopTimeOutOfRange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event loopTimeOutOfRange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_loopTimeOutOfRange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event loopTimeOutOfRange generated =
    Comment    ======= Verify ${subSystem}_settingsApplied_Example test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsApplied_Example
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsApplied_Example iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsApplied_Example_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsApplied_Example generated =

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${detailedState_start}
    ${detailedState_end}=    Evaluate    ${end}+${1}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${spectrographInPosition_start}=    Get Index From List    ${full_list}    === Event spectrographInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${spectrographInPosition_start}
    ${spectrographInPosition_end}=    Evaluate    ${end}+${1}
    ${spectrographInPosition_list}=    Get Slice From List    ${full_list}    start=${spectrographInPosition_start}    end=${spectrographInPosition_end}
    Should Contain X Times    ${spectrographInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${spectrographInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${telescopeInPosition_start}=    Get Index From List    ${full_list}    === Event telescopeInPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${telescopeInPosition_start}
    ${telescopeInPosition_end}=    Evaluate    ${end}+${1}
    ${telescopeInPosition_list}=    Get Slice From List    ${full_list}    start=${telescopeInPosition_start}    end=${telescopeInPosition_end}
    Should Contain X Times    ${telescopeInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${telescopeInPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedCommand_start}=    Get Index From List    ${full_list}    === Event rejectedCommand received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rejectedCommand_start}
    ${rejectedCommand_end}=    Evaluate    ${end}+${1}
    ${rejectedCommand_list}=    Get Slice From List    ${full_list}    start=${rejectedCommand_start}    end=${rejectedCommand_end}
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandValue : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
    ${settingsApplied_Example_start}=    Get Index From List    ${full_list}    === Event settingsApplied_Example received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsApplied_Example_start}
    ${settingsApplied_Example_end}=    Evaluate    ${end}+${1}
    ${settingsApplied_Example_list}=    Get Slice From List    ${full_list}    start=${settingsApplied_Example_start}    end=${settingsApplied_Example_end}
    Should Contain X Times    ${settingsApplied_Example_list}    ${SPACE}${SPACE}${SPACE}${SPACE}example : LSST    1
    Should Contain X Times    ${settingsApplied_Example_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
