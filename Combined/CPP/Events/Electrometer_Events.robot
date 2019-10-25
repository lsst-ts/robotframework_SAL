*** Settings ***
Documentation    Electrometer_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Electrometer
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
    Comment    ======= Verify ${subSystem}_digitalFilterChange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_digitalFilterChange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event digitalFilterChange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_digitalFilterChange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event digitalFilterChange generated =
    Comment    ======= Verify ${subSystem}_integrationTime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_integrationTime
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event integrationTime iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_integrationTime_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event integrationTime generated =
    Comment    ======= Verify ${subSystem}_intensity test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_intensity
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event intensity iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_intensity_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event intensity generated =
    Comment    ======= Verify ${subSystem}_largeFileObjectAvailable test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_largeFileObjectAvailable
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event largeFileObjectAvailable iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_largeFileObjectAvailable_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event largeFileObjectAvailable generated =
    Comment    ======= Verify ${subSystem}_measureRange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_measureRange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event measureRange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_measureRange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event measureRange generated =
    Comment    ======= Verify ${subSystem}_measureType test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_measureType
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event measureType iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_measureType_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event measureType generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedReadSets test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedReadSets
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedReadSets iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedReadSets_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedReadSets generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedSerConf test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedSerConf
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedSerConf iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedSerConf_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedSerConf generated =
    Comment    ======= Verify ${subSystem}_deviceErrorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_deviceErrorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event deviceErrorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_deviceErrorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event deviceErrorCode generated =
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
    Should Contain    ${output.stdout}    ===== ${subSystem} loggers ready
    ${detailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState start of topic ===
    ${detailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState end of topic ===
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${digitalFilterChange_start}=    Get Index From List    ${full_list}    === ${subSystem}_digitalFilterChange start of topic ===
    ${digitalFilterChange_end}=    Get Index From List    ${full_list}    === ${subSystem}_digitalFilterChange end of topic ===
    ${digitalFilterChange_list}=    Get Slice From List    ${full_list}    start=${digitalFilterChange_start}    end=${digitalFilterChange_end}
    Should Contain X Times    ${digitalFilterChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activateFilter : 1    1
    Should Contain X Times    ${digitalFilterChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activateMedianFilter : 1    1
    Should Contain X Times    ${digitalFilterChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activateAverageFilter : 1    1
    Should Contain X Times    ${digitalFilterChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${integrationTime_start}=    Get Index From List    ${full_list}    === ${subSystem}_integrationTime start of topic ===
    ${integrationTime_end}=    Get Index From List    ${full_list}    === ${subSystem}_integrationTime end of topic ===
    ${integrationTime_list}=    Get Slice From List    ${full_list}    start=${integrationTime_start}    end=${integrationTime_end}
    Should Contain X Times    ${integrationTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intTime : 1    1
    Should Contain X Times    ${integrationTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${intensity_start}=    Get Index From List    ${full_list}    === ${subSystem}_intensity start of topic ===
    ${intensity_end}=    Get Index From List    ${full_list}    === ${subSystem}_intensity end of topic ===
    ${intensity_list}=    Get Slice From List    ${full_list}    start=${intensity_start}    end=${intensity_end}
    Should Contain X Times    ${intensity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intensity : 1    1
    Should Contain X Times    ${intensity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unit : LSST    1
    Should Contain X Times    ${intensity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${intensity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === ${subSystem}_largeFileObjectAvailable start of topic ===
    ${largeFileObjectAvailable_end}=    Get Index From List    ${full_list}    === ${subSystem}_largeFileObjectAvailable end of topic ===
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end}
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : LSST    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generator : LSST    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}checkSum : LSST    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mimeType : LSST    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byteSize : 1    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : LSST    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${measureRange_start}=    Get Index From List    ${full_list}    === ${subSystem}_measureRange start of topic ===
    ${measureRange_end}=    Get Index From List    ${full_list}    === ${subSystem}_measureRange end of topic ===
    ${measureRange_list}=    Get Slice From List    ${full_list}    start=${measureRange_start}    end=${measureRange_end}
    Should Contain X Times    ${measureRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rangeValue : 1    1
    Should Contain X Times    ${measureRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${measureType_start}=    Get Index From List    ${full_list}    === ${subSystem}_measureType start of topic ===
    ${measureType_end}=    Get Index From List    ${full_list}    === ${subSystem}_measureType end of topic ===
    ${measureType_list}=    Get Slice From List    ${full_list}    start=${measureType_start}    end=${measureType_end}
    Should Contain X Times    ${measureType_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${measureType_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedReadSets_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedReadSets start of topic ===
    ${settingsAppliedReadSets_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedReadSets end of topic ===
    ${settingsAppliedReadSets_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedReadSets_start}    end=${settingsAppliedReadSets_end}
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterActive : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avgFilterActive : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputRange : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}integrationTime : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}medianFilterActive : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedSerConf_start}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedSerConf start of topic ===
    ${settingsAppliedSerConf_end}=    Get Index From List    ${full_list}    === ${subSystem}_settingsAppliedSerConf end of topic ===
    ${settingsAppliedSerConf_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedSerConf_start}    end=${settingsAppliedSerConf_end}
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}visaResource : LSST    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}baudRate : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parity : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataBits : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stopBits : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}termChar : LSST    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xonxoff : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dsrdtr : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bytesToRead : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${deviceErrorCode_start}=    Get Index From List    ${full_list}    === ${subSystem}_deviceErrorCode start of topic ===
    ${deviceErrorCode_end}=    Get Index From List    ${full_list}    === ${subSystem}_deviceErrorCode end of topic ===
    ${deviceErrorCode_list}=    Get Slice From List    ${full_list}    start=${deviceErrorCode_start}    end=${deviceErrorCode_end}
    Should Contain X Times    ${deviceErrorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${deviceErrorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : LSST    1
    Should Contain X Times    ${deviceErrorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
