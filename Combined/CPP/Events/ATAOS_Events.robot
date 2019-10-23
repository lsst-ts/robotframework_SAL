*** Settings ***
Documentation    ATAOS_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    ATAOS
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
    Comment    ======= Verify ${subSystem}_correctionEnabled test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_correctionEnabled
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event correctionEnabled iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_correctionEnabled_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event correctionEnabled generated =
    Comment    ======= Verify ${subSystem}_newFocusValue test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_newFocusValue
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event newFocusValue iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_newFocusValue_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event newFocusValue generated =
    Comment    ======= Verify ${subSystem}_m1CorrectionStarted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1CorrectionStarted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1CorrectionStarted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1CorrectionStarted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1CorrectionStarted generated =
    Comment    ======= Verify ${subSystem}_m1CorrectionCompleted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m1CorrectionCompleted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m1CorrectionCompleted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m1CorrectionCompleted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m1CorrectionCompleted generated =
    Comment    ======= Verify ${subSystem}_m2CorrectionStarted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2CorrectionStarted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2CorrectionStarted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2CorrectionStarted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2CorrectionStarted generated =
    Comment    ======= Verify ${subSystem}_m2CorrectionCompleted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_m2CorrectionCompleted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event m2CorrectionCompleted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_m2CorrectionCompleted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event m2CorrectionCompleted generated =
    Comment    ======= Verify ${subSystem}_hexapodCorrectionStarted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hexapodCorrectionStarted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event hexapodCorrectionStarted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hexapodCorrectionStarted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hexapodCorrectionStarted generated =
    Comment    ======= Verify ${subSystem}_hexapodCorrectionCompleted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_hexapodCorrectionCompleted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event hexapodCorrectionCompleted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_hexapodCorrectionCompleted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event hexapodCorrectionCompleted generated =
    Comment    ======= Verify ${subSystem}_focusCorrectionStarted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focusCorrectionStarted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event focusCorrectionStarted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focusCorrectionStarted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focusCorrectionStarted generated =
    Comment    ======= Verify ${subSystem}_focusCorrectionCompleted test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_focusCorrectionCompleted
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event focusCorrectionCompleted iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_focusCorrectionCompleted_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event focusCorrectionCompleted generated =
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingVersions generated =
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event errorCode generated =
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event summaryState generated =
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event appliedSettingsMatchStart iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event appliedSettingsMatchStart generated =
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logLevel generated =
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event logMessage generated =
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_softwareVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_softwareVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event heartbeat generated =

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain    ${output.stdout}    ===== ${subSystem} all loggers ready =====
    ${detailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState start of topic ===
    ${detailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState end of topic ===
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}substate : \x01    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${correctionEnabled_start}=    Get Index From List    ${full_list}    === ${subSystem}_correctionEnabled start of topic ===
    ${correctionEnabled_end}=    Get Index From List    ${full_list}    === ${subSystem}_correctionEnabled end of topic ===
    ${correctionEnabled_list}=    Get Slice From List    ${full_list}    start=${correctionEnabled_start}    end=${correctionEnabled_end}
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m1 : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}m2 : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}hexapod : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}moveWhileExposing : 1    1
    Should Contain X Times    ${correctionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${newFocusValue_start}=    Get Index From List    ${full_list}    === ${subSystem}_newFocusValue start of topic ===
    ${newFocusValue_end}=    Get Index From List    ${full_list}    === ${subSystem}_newFocusValue end of topic ===
    ${newFocusValue_list}=    Get Slice From List    ${full_list}    start=${newFocusValue_start}    end=${newFocusValue_end}
    Should Contain X Times    ${newFocusValue_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain X Times    ${newFocusValue_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1CorrectionStarted_start}=    Get Index From List    ${full_list}    === ${subSystem}_m1CorrectionStarted start of topic ===
    ${m1CorrectionStarted_end}=    Get Index From List    ${full_list}    === ${subSystem}_m1CorrectionStarted end of topic ===
    ${m1CorrectionStarted_list}=    Get Slice From List    ${full_list}    start=${m1CorrectionStarted_start}    end=${m1CorrectionStarted_end}
    Should Contain X Times    ${m1CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${m1CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${m1CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m1CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m1CorrectionCompleted_start}=    Get Index From List    ${full_list}    === ${subSystem}_m1CorrectionCompleted start of topic ===
    ${m1CorrectionCompleted_end}=    Get Index From List    ${full_list}    === ${subSystem}_m1CorrectionCompleted end of topic ===
    ${m1CorrectionCompleted_list}=    Get Slice From List    ${full_list}    start=${m1CorrectionCompleted_start}    end=${m1CorrectionCompleted_end}
    Should Contain X Times    ${m1CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${m1CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${m1CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m1CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m2CorrectionStarted_start}=    Get Index From List    ${full_list}    === ${subSystem}_m2CorrectionStarted start of topic ===
    ${m2CorrectionStarted_end}=    Get Index From List    ${full_list}    === ${subSystem}_m2CorrectionStarted end of topic ===
    ${m2CorrectionStarted_list}=    Get Slice From List    ${full_list}    start=${m2CorrectionStarted_start}    end=${m2CorrectionStarted_end}
    Should Contain X Times    ${m2CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${m2CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${m2CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m2CorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${m2CorrectionCompleted_start}=    Get Index From List    ${full_list}    === ${subSystem}_m2CorrectionCompleted start of topic ===
    ${m2CorrectionCompleted_end}=    Get Index From List    ${full_list}    === ${subSystem}_m2CorrectionCompleted end of topic ===
    ${m2CorrectionCompleted_list}=    Get Slice From List    ${full_list}    start=${m2CorrectionCompleted_start}    end=${m2CorrectionCompleted_end}
    Should Contain X Times    ${m2CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${m2CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${m2CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}pressure : 1    1
    Should Contain X Times    ${m2CorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${hexapodCorrectionStarted_start}=    Get Index From List    ${full_list}    === ${subSystem}_hexapodCorrectionStarted start of topic ===
    ${hexapodCorrectionStarted_end}=    Get Index From List    ${full_list}    === ${subSystem}_hexapodCorrectionStarted end of topic ===
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
    ${hexapodCorrectionCompleted_start}=    Get Index From List    ${full_list}    === ${subSystem}_hexapodCorrectionCompleted start of topic ===
    ${hexapodCorrectionCompleted_end}=    Get Index From List    ${full_list}    === ${subSystem}_hexapodCorrectionCompleted end of topic ===
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
    ${focusCorrectionStarted_start}=    Get Index From List    ${full_list}    === ${subSystem}_focusCorrectionStarted start of topic ===
    ${focusCorrectionStarted_end}=    Get Index From List    ${full_list}    === ${subSystem}_focusCorrectionStarted end of topic ===
    ${focusCorrectionStarted_list}=    Get Slice From List    ${full_list}    start=${focusCorrectionStarted_start}    end=${focusCorrectionStarted_end}
    Should Contain X Times    ${focusCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${focusCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${focusCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain X Times    ${focusCorrectionStarted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${focusCorrectionCompleted_start}=    Get Index From List    ${full_list}    === ${subSystem}_focusCorrectionCompleted start of topic ===
    ${focusCorrectionCompleted_end}=    Get Index From List    ${full_list}    === ${subSystem}_focusCorrectionCompleted end of topic ===
    ${focusCorrectionCompleted_list}=    Get Slice From List    ${full_list}    start=${focusCorrectionCompleted_start}    end=${focusCorrectionCompleted_end}
    Should Contain X Times    ${focusCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}azimuth : 1    1
    Should Contain X Times    ${focusCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}elevation : 1    1
    Should Contain X Times    ${focusCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}focus : 1    1
    Should Contain X Times    ${focusCorrectionCompleted_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingVersions_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingVersions start of topic ===
    ${settingVersions_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingVersions end of topic ===
    ${settingVersions_list}=    Get Slice From List    ${full_list}    start=${settingVersions_start}    end=${settingVersions_end}
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsVersion : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}recommendedSettingsLabels : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}settingsUrl : LSST    1
    Should Contain X Times    ${settingVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === ${subSystem}_errorCode start of topic ===
    ${errorCode_end}=    Get Index From List    ${full_list}    === ${subSystem}_errorCode end of topic ===
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${errorCode_end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === ${subSystem}_summaryState start of topic ===
    ${summaryState_end}=    Get Index From List    ${full_list}    === ${subSystem}_summaryState end of topic ===
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${summaryState_end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${appliedSettingsMatchStart_start}=    Get Index From List    ${full_list}    === ${subSystem}_appliedSettingsMatchStart start of topic ===
    ${appliedSettingsMatchStart_end}=    Get Index From List    ${full_list}    === ${subSystem}_appliedSettingsMatchStart end of topic ===
    ${appliedSettingsMatchStart_list}=    Get Slice From List    ${full_list}    start=${appliedSettingsMatchStart_start}    end=${appliedSettingsMatchStart_end}
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}appliedSettingsMatchStartIsTrue : 1    1
    Should Contain X Times    ${appliedSettingsMatchStart_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === ${subSystem}_logLevel start of topic ===
    ${logLevel_end}=    Get Index From List    ${full_list}    === ${subSystem}_logLevel end of topic ===
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${logLevel_end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === ${subSystem}_logMessage start of topic ===
    ${logMessage_end}=    Get Index From List    ${full_list}    === ${subSystem}_logMessage end of topic ===
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${logMessage_end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : LSST    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === ${subSystem}_simulationMode start of topic ===
    ${simulationMode_end}=    Get Index From List    ${full_list}    === ${subSystem}_simulationMode end of topic ===
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${simulationMode_end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === ${subSystem}_softwareVersions start of topic ===
    ${softwareVersions_end}=    Get Index From List    ${full_list}    === ${subSystem}_softwareVersions end of topic ===
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${softwareVersions_end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : LSST    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
