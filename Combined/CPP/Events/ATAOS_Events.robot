*** Settings ***
Documentation    ATAOS_Events communications tests.
Force Tags    messaging    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATAOS
${component}    all
${timeout}    90s

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
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event detailedState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event detailedState generated =
    Comment    ======= Verify ${subSystem}_correctionEnabled test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_correctionEnabled
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event correctionEnabled iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_correctionEnabled_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event correctionEnabled generated =
    Comment    ======= Verify ${subSystem}_m1CorrectionStarted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1CorrectionStarted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1CorrectionStarted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1CorrectionStarted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1CorrectionStarted generated =
    Comment    ======= Verify ${subSystem}_m1CorrectionCompleted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1CorrectionCompleted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1CorrectionCompleted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1CorrectionCompleted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1CorrectionCompleted generated =
    Comment    ======= Verify ${subSystem}_m2CorrectionStarted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2CorrectionStarted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2CorrectionStarted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2CorrectionStarted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2CorrectionStarted generated =
    Comment    ======= Verify ${subSystem}_m2CorrectionCompleted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2CorrectionCompleted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2CorrectionCompleted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2CorrectionCompleted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2CorrectionCompleted generated =
    Comment    ======= Verify ${subSystem}_hexapodCorrectionStarted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hexapodCorrectionStarted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hexapodCorrectionStarted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hexapodCorrectionStarted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hexapodCorrectionStarted generated =
    Comment    ======= Verify ${subSystem}_hexapodCorrectionCompleted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hexapodCorrectionCompleted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event hexapodCorrectionCompleted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hexapodCorrectionCompleted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hexapodCorrectionCompleted generated =
    Comment    ======= Verify ${subSystem}_focusCorrectionStarted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focusCorrectionStarted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focusCorrectionStarted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focusCorrectionStarted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focusCorrectionStarted generated =
    Comment    ======= Verify ${subSystem}_focusCorrectionCompleted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focusCorrectionCompleted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focusCorrectionCompleted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focusCorrectionCompleted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focusCorrectionCompleted generated =
    Comment    ======= Verify ${subSystem}_atspectrographCorrectionStarted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_atspectrographCorrectionStarted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event atspectrographCorrectionStarted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_atspectrographCorrectionStarted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event atspectrographCorrectionStarted generated =
    Comment    ======= Verify ${subSystem}_atspectrographCorrectionCompleted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_atspectrographCorrectionCompleted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event atspectrographCorrectionCompleted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_atspectrographCorrectionCompleted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event atspectrographCorrectionCompleted generated =
    Comment    ======= Verify ${subSystem}_correctionOffsets test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_correctionOffsets
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event correctionOffsets iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_correctionOffsets_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event correctionOffsets generated =
    Comment    ======= Verify ${subSystem}_focusOffsetSummary test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focusOffsetSummary
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event focusOffsetSummary iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focusOffsetSummary_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focusOffsetSummary generated =
    Comment    ======= Verify ${subSystem}_pointingOffsetSummary test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_pointingOffsetSummary
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event pointingOffsetSummary iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_pointingOffsetSummary_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event pointingOffsetSummary generated =

Read Logger
    [Tags]    functional
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${detailedState_start}=    Get Index From List    ${full_list}    === Event detailedState received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${detailedState_start}
    ${detailedState_end}=    Evaluate    ${end}+${1}
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : \x01    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${correctionEnabled_start}=    Get Index From List    ${full_list}    === Event correctionEnabled received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${correctionEnabled_start}
    ${correctionEnabled_end}=    Evaluate    ${end}+${1}
    ${correctionEnabled_list}=    Get Slice From List    ${full_list}    start=${correctionEnabled_start}    end=${correctionEnabled_end}
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m1 : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m2 : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}atspectrograph : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moveWhileExposing : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1CorrectionStarted_start}=    Get Index From List    ${full_list}    === Event m1CorrectionStarted received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m1CorrectionStarted_start}
    ${m1CorrectionStarted_end}=    Evaluate    ${end}+${1}
    ${m1CorrectionStarted_list}=    Get Slice From List    ${full_list}    start=${m1CorrectionStarted_start}    end=${m1CorrectionStarted_end}
    Should Contain X Times    ${m1CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${m1CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${m1CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m1CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1CorrectionCompleted_start}=    Get Index From List    ${full_list}    === Event m1CorrectionCompleted received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m1CorrectionCompleted_start}
    ${m1CorrectionCompleted_end}=    Evaluate    ${end}+${1}
    ${m1CorrectionCompleted_list}=    Get Slice From List    ${full_list}    start=${m1CorrectionCompleted_start}    end=${m1CorrectionCompleted_end}
    Should Contain X Times    ${m1CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${m1CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${m1CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m1CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m2CorrectionStarted_start}=    Get Index From List    ${full_list}    === Event m2CorrectionStarted received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m2CorrectionStarted_start}
    ${m2CorrectionStarted_end}=    Evaluate    ${end}+${1}
    ${m2CorrectionStarted_list}=    Get Slice From List    ${full_list}    start=${m2CorrectionStarted_start}    end=${m2CorrectionStarted_end}
    Should Contain X Times    ${m2CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${m2CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${m2CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m2CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m2CorrectionCompleted_start}=    Get Index From List    ${full_list}    === Event m2CorrectionCompleted received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${m2CorrectionCompleted_start}
    ${m2CorrectionCompleted_end}=    Evaluate    ${end}+${1}
    ${m2CorrectionCompleted_list}=    Get Slice From List    ${full_list}    start=${m2CorrectionCompleted_start}    end=${m2CorrectionCompleted_end}
    Should Contain X Times    ${m2CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${m2CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${m2CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m2CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hexapodCorrectionStarted_start}=    Get Index From List    ${full_list}    === Event hexapodCorrectionStarted received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${hexapodCorrectionStarted_start}
    ${hexapodCorrectionStarted_end}=    Evaluate    ${end}+${1}
    ${hexapodCorrectionStarted_list}=    Get Slice From List    ${full_list}    start=${hexapodCorrectionStarted_start}    end=${hexapodCorrectionStarted_end}
    Should Contain X Times    ${hexapodCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${hexapodCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${hexapodCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_x : 1    1
    Should Contain X Times    ${hexapodCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_y : 1    1
    Should Contain X Times    ${hexapodCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_z : 1    1
    Should Contain X Times    ${hexapodCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_u : 1    1
    Should Contain X Times    ${hexapodCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_v : 1    1
    Should Contain X Times    ${hexapodCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_w : 1    1
    Should Contain X Times    ${hexapodCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hexapodCorrectionCompleted_start}=    Get Index From List    ${full_list}    === Event hexapodCorrectionCompleted received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${hexapodCorrectionCompleted_start}
    ${hexapodCorrectionCompleted_end}=    Evaluate    ${end}+${1}
    ${hexapodCorrectionCompleted_list}=    Get Slice From List    ${full_list}    start=${hexapodCorrectionCompleted_start}    end=${hexapodCorrectionCompleted_end}
    Should Contain X Times    ${hexapodCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${hexapodCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${hexapodCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_x : 1    1
    Should Contain X Times    ${hexapodCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_y : 1    1
    Should Contain X Times    ${hexapodCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_z : 1    1
    Should Contain X Times    ${hexapodCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_u : 1    1
    Should Contain X Times    ${hexapodCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_v : 1    1
    Should Contain X Times    ${hexapodCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod_w : 1    1
    Should Contain X Times    ${hexapodCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focusCorrectionStarted_start}=    Get Index From List    ${full_list}    === Event focusCorrectionStarted received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focusCorrectionStarted_start}
    ${focusCorrectionStarted_end}=    Evaluate    ${end}+${1}
    ${focusCorrectionStarted_list}=    Get Slice From List    ${full_list}    start=${focusCorrectionStarted_start}    end=${focusCorrectionStarted_end}
    Should Contain X Times    ${focusCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${focusCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${focusCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain X Times    ${focusCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focusCorrectionCompleted_start}=    Get Index From List    ${full_list}    === Event focusCorrectionCompleted received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focusCorrectionCompleted_start}
    ${focusCorrectionCompleted_end}=    Evaluate    ${end}+${1}
    ${focusCorrectionCompleted_list}=    Get Slice From List    ${full_list}    start=${focusCorrectionCompleted_start}    end=${focusCorrectionCompleted_end}
    Should Contain X Times    ${focusCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${focusCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${focusCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain X Times    ${focusCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${atspectrographCorrectionStarted_start}=    Get Index From List    ${full_list}    === Event atspectrographCorrectionStarted received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${atspectrographCorrectionStarted_start}
    ${atspectrographCorrectionStarted_end}=    Evaluate    ${end}+${1}
    ${atspectrographCorrectionStarted_list}=    Get Slice From List    ${full_list}    start=${atspectrographCorrectionStarted_start}    end=${atspectrographCorrectionStarted_end}
    Should Contain X Times    ${atspectrographCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focusOffset : 1    1
    Should Contain X Times    ${atspectrographCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOffsets : 0    1
    Should Contain X Times    ${atspectrographCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${atspectrographCorrectionCompleted_start}=    Get Index From List    ${full_list}    === Event atspectrographCorrectionCompleted received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${atspectrographCorrectionCompleted_start}
    ${atspectrographCorrectionCompleted_end}=    Evaluate    ${end}+${1}
    ${atspectrographCorrectionCompleted_list}=    Get Slice From List    ${full_list}    start=${atspectrographCorrectionCompleted_start}    end=${atspectrographCorrectionCompleted_end}
    Should Contain X Times    ${atspectrographCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focusOffset : 1    1
    Should Contain X Times    ${atspectrographCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pointingOffsets : 0    1
    Should Contain X Times    ${atspectrographCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${correctionOffsets_start}=    Get Index From List    ${full_list}    === Event correctionOffsets received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${correctionOffsets_start}
    ${correctionOffsets_end}=    Evaluate    ${end}+${1}
    ${correctionOffsets_list}=    Get Slice From List    ${full_list}    start=${correctionOffsets_start}    end=${correctionOffsets_end}
    Should Contain X Times    ${correctionOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}x : 1    1
    Should Contain X Times    ${correctionOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}y : 1    1
    Should Contain X Times    ${correctionOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}z : 1    1
    Should Contain X Times    ${correctionOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}u : 1    1
    Should Contain X Times    ${correctionOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}v : 1    1
    Should Contain X Times    ${correctionOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}w : 1    1
    Should Contain X Times    ${correctionOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m1 : 1    1
    Should Contain X Times    ${correctionOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m2 : 1    1
    Should Contain X Times    ${correctionOffsets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focusOffsetSummary_start}=    Get Index From List    ${full_list}    === Event focusOffsetSummary received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${focusOffsetSummary_start}
    ${focusOffsetSummary_end}=    Evaluate    ${end}+${1}
    ${focusOffsetSummary_list}=    Get Slice From List    ${full_list}    start=${focusOffsetSummary_start}    end=${focusOffsetSummary_end}
    Should Contain X Times    ${focusOffsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}total : 1    1
    Should Contain X Times    ${focusOffsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}userApplied : 1    1
    Should Contain X Times    ${focusOffsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter : 1    1
    Should Contain X Times    ${focusOffsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}disperser : 1    1
    Should Contain X Times    ${focusOffsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelength : 1    1
    Should Contain X Times    ${focusOffsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${pointingOffsetSummary_start}=    Get Index From List    ${full_list}    === Event pointingOffsetSummary received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${pointingOffsetSummary_start}
    ${pointingOffsetSummary_end}=    Evaluate    ${end}+${1}
    ${pointingOffsetSummary_list}=    Get Slice From List    ${full_list}    start=${pointingOffsetSummary_start}    end=${pointingOffsetSummary_end}
    Should Contain X Times    ${pointingOffsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}total : 0    1
    Should Contain X Times    ${pointingOffsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filter : 0    1
    Should Contain X Times    ${pointingOffsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}disperser : 0    1
    Should Contain X Times    ${pointingOffsetSummary_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
