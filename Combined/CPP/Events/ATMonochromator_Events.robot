*** Settings ***
Documentation    ATMonochromator_Events communications tests.
Force Tags    cpp    
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    200s    5s    File Should Not Be Empty    ${EXECDIR}${/}stdout.txt
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Should Contain    ${output}    ===== ${subSystem} all loggers ready =====
    Sleep    6s

Start Sender
    [Tags]    functional
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    Comment    ======= Verify ${subSystem}_internalCommand test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_internalCommand
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_internalCommand_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_internalCommand end of topic ===
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_heartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_heartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_heartbeat end of topic ===
    Comment    ======= Verify ${subSystem}_loopTimeOutOfRange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_loopTimeOutOfRange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_loopTimeOutOfRange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_loopTimeOutOfRange end of topic ===
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_detailedState end of topic ===
    Comment    ======= Verify ${subSystem}_rejectedCommand test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rejectedCommand
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rejectedCommand_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_rejectedCommand end of topic ===
    Comment    ======= Verify ${subSystem}_settingsAppliedMonoCommunication test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedMonoCommunication
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedMonoCommunication_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_settingsAppliedMonoCommunication end of topic ===
    Comment    ======= Verify ${subSystem}_selectedGrating test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_selectedGrating
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_selectedGrating_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_selectedGrating end of topic ===
    Comment    ======= Verify ${subSystem}_wavelength test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_wavelength
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_wavelength_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_wavelength end of topic ===
    Comment    ======= Verify ${subSystem}_slitWidth test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_slitWidth
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_slitWidth_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_slitWidth end of topic ===
    Comment    ======= Verify ${subSystem}_inPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_inPosition end of topic ===
    Comment    ======= Verify ${subSystem}_monochromatorConnected test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_monochromatorConnected
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_monochromatorConnected_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_monochromatorConnected end of topic ===
    Comment    ======= Verify ${subSystem}_settingsAppliedMonoHeartbeat test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedMonoHeartbeat
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedMonoHeartbeat_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_settingsAppliedMonoHeartbeat end of topic ===
    Comment    ======= Verify ${subSystem}_settingsAppliedLoop test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedLoop
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedLoop_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_settingsAppliedLoop end of topic ===
    Comment    ======= Verify ${subSystem}_settingsAppliedMonochromatorRanges test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedMonochromatorRanges
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedMonochromatorRanges_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_settingsAppliedMonochromatorRanges end of topic ===
    Comment    ======= Verify ${subSystem}_settingVersions test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingVersions
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingVersions_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_settingVersions end of topic ===
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_errorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_errorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_errorCode end of topic ===
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_summaryState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_summaryState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_summaryState end of topic ===
    Comment    ======= Verify ${subSystem}_appliedSettingsMatchStart test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_appliedSettingsMatchStart
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_appliedSettingsMatchStart_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_appliedSettingsMatchStart end of topic ===
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logLevel
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logLevel_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_logLevel end of topic ===
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_logMessage
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_logMessage_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_logMessage end of topic ===
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_simulationMode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_simulationMode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_simulationMode end of topic ===

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=1
    Should Contain    ${output.stdout}    ===== ${subSystem} all loggers ready =====
    ${internalCommand_start}=    Get Index From List    ${full_list}    === ${subSystem}_internalCommand start of topic ===
    ${internalCommand_end}=    Get Index From List    ${full_list}    === ${subSystem}_internalCommand end of topic ===
    ${internalCommand_list}=    Get Slice From List    ${full_list}    start=${internalCommand_start}    end=${internalCommand_end}
    Should Contain X Times    ${internalCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandObject : \x00    1
    Should Contain X Times    ${internalCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat start of topic ===
    ${heartbeat_end}=    Get Index From List    ${full_list}    === ${subSystem}_heartbeat end of topic ===
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${heartbeat_end}
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}heartbeat : 1    1
    Should Contain X Times    ${heartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${loopTimeOutOfRange_start}=    Get Index From List    ${full_list}    === ${subSystem}_loopTimeOutOfRange start of topic ===
    ${loopTimeOutOfRange_end}=    Get Index From List    ${full_list}    === ${subSystem}_loopTimeOutOfRange end of topic ===
    ${loopTimeOutOfRange_list}=    Get Slice From List    ${full_list}    start=${loopTimeOutOfRange_start}    end=${loopTimeOutOfRange_end}
    Should Contain X Times    ${loopTimeOutOfRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}loopTimeOutOfRange : 1    1
    Should Contain X Times    ${loopTimeOutOfRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${detailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState start of topic ===
    ${detailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState end of topic ===
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rejectedCommand_start}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedCommand start of topic ===
    ${rejectedCommand_end}=    Get Index From List    ${full_list}    === ${subSystem}_rejectedCommand end of topic ===
    ${rejectedCommand_list}=    Get Slice From List    ${full_list}    start=${rejectedCommand_start}    end=${rejectedCommand_end}
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}commandValue : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${rejectedCommand_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedMonoCommunication_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedMonoCommunication start of topic ===
    ${settingsAppliedMonoCommunication_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedMonoCommunication end of topic ===
    ${settingsAppliedMonoCommunication_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedMonoCommunication_start}    end=${settingsAppliedMonoCommunication_end}
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}ip : LSST    1
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}portRange : 1    1
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}readTimeout : 1    1
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}writeTimeout : 1    1
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}connectionTimeout : 1    1
    Should Contain X Times    ${settingsAppliedMonoCommunication_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${selectedGrating_start}=    Get Index From List    ${full_list}    === ${subSystem}_selectedGrating start of topic ===
    ${selectedGrating_end}=    Get Index From List    ${full_list}    === ${subSystem}_selectedGrating end of topic ===
    ${selectedGrating_list}=    Get Slice From List    ${full_list}    start=${selectedGrating_start}    end=${selectedGrating_end}
    Should Contain X Times    ${selectedGrating_list}    ${SPACE}${SPACE}${SPACE}${SPACE}gratingType : 1    1
    Should Contain X Times    ${selectedGrating_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${selectedGrating_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${wavelength_start}=    Get Index From List    ${full_list}    === ${subSystem}_wavelength start of topic ===
    ${wavelength_end}=    Get Index From List    ${full_list}    === ${subSystem}_wavelength end of topic ===
    ${wavelength_list}=    Get Slice From List    ${full_list}    start=${wavelength_start}    end=${wavelength_end}
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelength : 1    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${wavelength_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${slitWidth_start}=    Get Index From List    ${full_list}    === ${subSystem}_slitWidth start of topic ===
    ${slitWidth_end}=    Get Index From List    ${full_list}    === ${subSystem}_slitWidth end of topic ===
    ${slitWidth_list}=    Get Slice From List    ${full_list}    start=${slitWidth_start}    end=${slitWidth_end}
    Should Contain X Times    ${slitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slit : 1    1
    Should Contain X Times    ${slitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}slitPosition : 1    1
    Should Contain X Times    ${slitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${slitWidth_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPosition_start}=    Get Index From List    ${full_list}    === ${subSystem}_inPosition start of topic ===
    ${inPosition_end}=    Get Index From List    ${full_list}    === ${subSystem}_inPosition end of topic ===
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${inPosition_end}
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}device : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${monochromatorConnected_start}=    Get Index From List    ${full_list}    === ${subSystem}_monochromatorConnected start of topic ===
    ${monochromatorConnected_end}=    Get Index From List    ${full_list}    === ${subSystem}_monochromatorConnected end of topic ===
    ${monochromatorConnected_list}=    Get Slice From List    ${full_list}    start=${monochromatorConnected_start}    end=${monochromatorConnected_end}
    Should Contain X Times    ${monochromatorConnected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}connected : 1    1
    Should Contain X Times    ${monochromatorConnected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedMonoHeartbeat_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedMonoHeartbeat start of topic ===
    ${settingsAppliedMonoHeartbeat_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedMonoHeartbeat end of topic ===
    ${settingsAppliedMonoHeartbeat_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedMonoHeartbeat_start}    end=${settingsAppliedMonoHeartbeat_end}
    Should Contain X Times    ${settingsAppliedMonoHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}period : 1    1
    Should Contain X Times    ${settingsAppliedMonoHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout : 1    1
    Should Contain X Times    ${settingsAppliedMonoHeartbeat_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedLoop_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedLoop start of topic ===
    ${settingsAppliedLoop_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedLoop end of topic ===
    ${settingsAppliedLoop_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedLoop_start}    end=${settingsAppliedLoop_end}
    Should Contain X Times    ${settingsAppliedLoop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}period : 1    1
    Should Contain X Times    ${settingsAppliedLoop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}periodAllowedJitter : 1    1
    Should Contain X Times    ${settingsAppliedLoop_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedMonochromatorRanges_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedMonochromatorRanges start of topic ===
    ${settingsAppliedMonochromatorRanges_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedMonochromatorRanges end of topic ===
    ${settingsAppliedMonochromatorRanges_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedMonochromatorRanges_start}    end=${settingsAppliedMonochromatorRanges_end}
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelengthGR1 : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelengthGR1_GR2 : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}wavelengthGR2 : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minSlitWidth : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxSlitWidth : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}minWavelength : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxWavelength : 1    1
    Should Contain X Times    ${settingsAppliedMonochromatorRanges_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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