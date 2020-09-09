*** Settings ***
Documentation    Electrometer_Events communications tests.
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
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Contain    "${output}"    "1"
    Wait Until Keyword Succeeds    60s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
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
    Comment    ======= Verify ${subSystem}_digitalFilterChange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_digitalFilterChange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event digitalFilterChange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_digitalFilterChange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event digitalFilterChange generated =
    Comment    ======= Verify ${subSystem}_integrationTime test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_integrationTime
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event integrationTime iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_integrationTime_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event integrationTime generated =
    Comment    ======= Verify ${subSystem}_intensity test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_intensity
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event intensity iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_intensity_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event intensity generated =
    Comment    ======= Verify ${subSystem}_largeFileObjectAvailable test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_largeFileObjectAvailable
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event largeFileObjectAvailable iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_largeFileObjectAvailable_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event largeFileObjectAvailable generated =
    Comment    ======= Verify ${subSystem}_measureRange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_measureRange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event measureRange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_measureRange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event measureRange generated =
    Comment    ======= Verify ${subSystem}_measureType test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_measureType
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event measureType iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_measureType_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event measureType generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedReadSets test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedReadSets
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedReadSets iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedReadSets_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedReadSets generated =
    Comment    ======= Verify ${subSystem}_settingsAppliedSerConf test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_settingsAppliedSerConf
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event settingsAppliedSerConf iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_settingsAppliedSerConf_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event settingsAppliedSerConf generated =
    Comment    ======= Verify ${subSystem}_deviceErrorCode test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_deviceErrorCode
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[2]
    Should Contain X Times    ${output.stdout}    === Event deviceErrorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_deviceErrorCode_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event deviceErrorCode generated =

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
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${digitalFilterChange_start}=    Get Index From List    ${full_list}    === Event digitalFilterChange received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${digitalFilterChange_start}
    ${digitalFilterChange_end}=    Evaluate    ${end}+${1}
    ${digitalFilterChange_list}=    Get Slice From List    ${full_list}    start=${digitalFilterChange_start}    end=${digitalFilterChange_end}
    Should Contain X Times    ${digitalFilterChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activateFilter : 1    1
    Should Contain X Times    ${digitalFilterChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activateMedianFilter : 1    1
    Should Contain X Times    ${digitalFilterChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}activateAverageFilter : 1    1
    Should Contain X Times    ${digitalFilterChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${integrationTime_start}=    Get Index From List    ${full_list}    === Event integrationTime received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${integrationTime_start}
    ${integrationTime_end}=    Evaluate    ${end}+${1}
    ${integrationTime_list}=    Get Slice From List    ${full_list}    start=${integrationTime_start}    end=${integrationTime_end}
    Should Contain X Times    ${integrationTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intTime : 1    1
    Should Contain X Times    ${integrationTime_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${intensity_start}=    Get Index From List    ${full_list}    === Event intensity received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${intensity_start}
    ${intensity_end}=    Evaluate    ${end}+${1}
    ${intensity_list}=    Get Slice From List    ${full_list}    start=${intensity_start}    end=${intensity_end}
    Should Contain X Times    ${intensity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}intensity : 1    1
    Should Contain X Times    ${intensity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}unit : RO    1
    Should Contain X Times    ${intensity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    Should Contain X Times    ${intensity_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${largeFileObjectAvailable_start}=    Get Index From List    ${full_list}    === Event largeFileObjectAvailable received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${largeFileObjectAvailable_start}
    ${largeFileObjectAvailable_end}=    Evaluate    ${end}+${1}
    ${largeFileObjectAvailable_list}=    Get Slice From List    ${full_list}    start=${largeFileObjectAvailable_start}    end=${largeFileObjectAvailable_end}
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}generator : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : 1    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}checkSum : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mimeType : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}byteSize : 1    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}id : RO    1
    Should Contain X Times    ${largeFileObjectAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${measureRange_start}=    Get Index From List    ${full_list}    === Event measureRange received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${measureRange_start}
    ${measureRange_end}=    Evaluate    ${end}+${1}
    ${measureRange_list}=    Get Slice From List    ${full_list}    start=${measureRange_start}    end=${measureRange_end}
    Should Contain X Times    ${measureRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rangeValue : 1    1
    Should Contain X Times    ${measureRange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${measureType_start}=    Get Index From List    ${full_list}    === Event measureType received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${measureType_start}
    ${measureType_end}=    Evaluate    ${end}+${1}
    ${measureType_list}=    Get Slice From List    ${full_list}    start=${measureType_start}    end=${measureType_end}
    Should Contain X Times    ${measureType_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${measureType_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedReadSets_start}=    Get Index From List    ${full_list}    === Event settingsAppliedReadSets received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedReadSets_start}
    ${settingsAppliedReadSets_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedReadSets_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedReadSets_start}    end=${settingsAppliedReadSets_end}
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filterActive : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}avgFilterActive : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inputRange : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}integrationTime : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}medianFilterActive : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    Should Contain X Times    ${settingsAppliedReadSets_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${settingsAppliedSerConf_start}=    Get Index From List    ${full_list}    === Event settingsAppliedSerConf received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${settingsAppliedSerConf_start}
    ${settingsAppliedSerConf_end}=    Evaluate    ${end}+${1}
    ${settingsAppliedSerConf_list}=    Get Slice From List    ${full_list}    start=${settingsAppliedSerConf_start}    end=${settingsAppliedSerConf_end}
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}visaResource : RO    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}baudRate : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}parity : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dataBits : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}stopBits : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timeout : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}termChar : RO    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xonxoff : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}dsrdtr : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}bytesToRead : 1    1
    Should Contain X Times    ${settingsAppliedSerConf_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${deviceErrorCode_start}=    Get Index From List    ${full_list}    === Event deviceErrorCode received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${deviceErrorCode_start}
    ${deviceErrorCode_end}=    Evaluate    ${end}+${1}
    ${deviceErrorCode_list}=    Get Slice From List    ${full_list}    start=${deviceErrorCode_start}    end=${deviceErrorCode_end}
    Should Contain X Times    ${deviceErrorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${deviceErrorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${deviceErrorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
