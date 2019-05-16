*** Settings ***
Documentation    DomeAPS_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    DomeAPS
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
    Comment    ======= Verify ${subSystem}_stateChanged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_stateChanged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_stateChanged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_stateChanged end of topic ===
    Comment    ======= Verify ${subSystem}_detailedState test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_detailedState
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_detailedState_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_detailedState end of topic ===
    Comment    ======= Verify ${subSystem}_driveEnabled test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_driveEnabled
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_driveEnabled_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_driveEnabled end of topic ===
    Comment    ======= Verify ${subSystem}_driveDisabled test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_driveDisabled
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_driveDisabled_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_driveDisabled end of topic ===
    Comment    ======= Verify ${subSystem}_driveReady test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_driveReady
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_driveReady_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_driveReady end of topic ===
    Comment    ======= Verify ${subSystem}_driveFault test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_driveFault
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_driveFault_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_driveFault end of topic ===
    Comment    ======= Verify ${subSystem}_movementEnabled test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_movementEnabled
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_movementEnabled_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_movementEnabled end of topic ===
    Comment    ======= Verify ${subSystem}_movementPrevented test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_movementPrevented
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_movementPrevented_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_movementPrevented end of topic ===
    Comment    ======= Verify ${subSystem}_lockingPinEngaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_lockingPinEngaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_lockingPinEngaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_lockingPinEngaged end of topic ===
    Comment    ======= Verify ${subSystem}_lockingPinDisengaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_lockingPinDisengaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_lockingPinDisengaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_lockingPinDisengaged end of topic ===
    Comment    ======= Verify ${subSystem}_lockingPinFloating test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_lockingPinFloating
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_lockingPinFloating_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_lockingPinFloating end of topic ===
    Comment    ======= Verify ${subSystem}_centralLockingPinEngaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_centralLockingPinEngaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_centralLockingPinEngaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_centralLockingPinEngaged end of topic ===
    Comment    ======= Verify ${subSystem}_lockingPinHomed test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_lockingPinHomed
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_lockingPinHomed_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_lockingPinHomed end of topic ===
    Comment    ======= Verify ${subSystem}_centralLockingPinDisengaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_centralLockingPinDisengaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_centralLockingPinDisengaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_centralLockingPinDisengaged end of topic ===
    Comment    ======= Verify ${subSystem}_centralLockingPinHomed test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_centralLockingPinHomed
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_centralLockingPinHomed_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_centralLockingPinHomed end of topic ===
    Comment    ======= Verify ${subSystem}_centralLockingPinFloating test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_centralLockingPinFloating
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_centralLockingPinFloating_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_centralLockingPinFloating end of topic ===
    Comment    ======= Verify ${subSystem}_brakeEngaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_brakeEngaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_brakeEngaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_brakeEngaged end of topic ===
    Comment    ======= Verify ${subSystem}_brakeDisengaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_brakeDisengaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_brakeDisengaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_brakeDisengaged end of topic ===
    Comment    ======= Verify ${subSystem}_echoResponse test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_echoResponse
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_echoResponse_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_echoResponse end of topic ===
    Comment    ======= Verify ${subSystem}_apsSubsystemError test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_apsSubsystemError
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_apsSubsystemError_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === ${subSystem}_apsSubsystemError end of topic ===
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
    ${stateChanged_start}=    Get Index From List    ${full_list}    === ${subSystem}_stateChanged start of topic ===
    ${stateChanged_end}=    Get Index From List    ${full_list}    === ${subSystem}_stateChanged end of topic ===
    ${stateChanged_list}=    Get Slice From List    ${full_list}    start=${stateChanged_start}    end=${stateChanged_end}
    Should Contain X Times    ${stateChanged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}newState : 1    1
    Should Contain X Times    ${stateChanged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${detailedState_start}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState start of topic ===
    ${detailedState_end}=    Get Index From List    ${full_list}    === ${subSystem}_detailedState end of topic ===
    ${detailedState_list}=    Get Slice From List    ${full_list}    start=${detailedState_start}    end=${detailedState_end}
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}detailedState : 1    1
    Should Contain X Times    ${detailedState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${driveEnabled_start}=    Get Index From List    ${full_list}    === ${subSystem}_driveEnabled start of topic ===
    ${driveEnabled_end}=    Get Index From List    ${full_list}    === ${subSystem}_driveEnabled end of topic ===
    ${driveEnabled_list}=    Get Slice From List    ${full_list}    start=${driveEnabled_start}    end=${driveEnabled_end}
    Should Contain X Times    ${driveEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveId : 1    1
    Should Contain X Times    ${driveEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${driveDisabled_start}=    Get Index From List    ${full_list}    === ${subSystem}_driveDisabled start of topic ===
    ${driveDisabled_end}=    Get Index From List    ${full_list}    === ${subSystem}_driveDisabled end of topic ===
    ${driveDisabled_list}=    Get Slice From List    ${full_list}    start=${driveDisabled_start}    end=${driveDisabled_end}
    Should Contain X Times    ${driveDisabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveId : 1    1
    Should Contain X Times    ${driveDisabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${driveReady_start}=    Get Index From List    ${full_list}    === ${subSystem}_driveReady start of topic ===
    ${driveReady_end}=    Get Index From List    ${full_list}    === ${subSystem}_driveReady end of topic ===
    ${driveReady_list}=    Get Slice From List    ${full_list}    start=${driveReady_start}    end=${driveReady_end}
    Should Contain X Times    ${driveReady_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveId : 1    1
    Should Contain X Times    ${driveReady_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${driveFault_start}=    Get Index From List    ${full_list}    === ${subSystem}_driveFault start of topic ===
    ${driveFault_end}=    Get Index From List    ${full_list}    === ${subSystem}_driveFault end of topic ===
    ${driveFault_list}=    Get Slice From List    ${full_list}    start=${driveFault_start}    end=${driveFault_end}
    Should Contain X Times    ${driveFault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveId : 1    1
    Should Contain X Times    ${driveFault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : LSST    1
    Should Contain X Times    ${driveFault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${movementEnabled_start}=    Get Index From List    ${full_list}    === ${subSystem}_movementEnabled start of topic ===
    ${movementEnabled_end}=    Get Index From List    ${full_list}    === ${subSystem}_movementEnabled end of topic ===
    ${movementEnabled_list}=    Get Slice From List    ${full_list}    start=${movementEnabled_start}    end=${movementEnabled_end}
    Should Contain X Times    ${movementEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${movementEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${movementPrevented_start}=    Get Index From List    ${full_list}    === ${subSystem}_movementPrevented start of topic ===
    ${movementPrevented_end}=    Get Index From List    ${full_list}    === ${subSystem}_movementPrevented end of topic ===
    ${movementPrevented_list}=    Get Slice From List    ${full_list}    start=${movementPrevented_start}    end=${movementPrevented_end}
    Should Contain X Times    ${movementPrevented_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${movementPrevented_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lockingPinEngaged_start}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinEngaged start of topic ===
    ${lockingPinEngaged_end}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinEngaged end of topic ===
    ${lockingPinEngaged_list}=    Get Slice From List    ${full_list}    start=${lockingPinEngaged_start}    end=${lockingPinEngaged_end}
    Should Contain X Times    ${lockingPinEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lockingPinID : 1    1
    Should Contain X Times    ${lockingPinEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lockingPinDisengaged_start}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinDisengaged start of topic ===
    ${lockingPinDisengaged_end}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinDisengaged end of topic ===
    ${lockingPinDisengaged_list}=    Get Slice From List    ${full_list}    start=${lockingPinDisengaged_start}    end=${lockingPinDisengaged_end}
    Should Contain X Times    ${lockingPinDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lockingPinID : 1    1
    Should Contain X Times    ${lockingPinDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lockingPinFloating_start}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinFloating start of topic ===
    ${lockingPinFloating_end}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinFloating end of topic ===
    ${lockingPinFloating_list}=    Get Slice From List    ${full_list}    start=${lockingPinFloating_start}    end=${lockingPinFloating_end}
    Should Contain X Times    ${lockingPinFloating_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lockingPinID : 1    1
    Should Contain X Times    ${lockingPinFloating_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${centralLockingPinEngaged_start}=    Get Index From List    ${full_list}    === ${subSystem}_centralLockingPinEngaged start of topic ===
    ${centralLockingPinEngaged_end}=    Get Index From List    ${full_list}    === ${subSystem}_centralLockingPinEngaged end of topic ===
    ${centralLockingPinEngaged_list}=    Get Slice From List    ${full_list}    start=${centralLockingPinEngaged_start}    end=${centralLockingPinEngaged_end}
    Should Contain X Times    ${centralLockingPinEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${centralLockingPinEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lockingPinHomed_start}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinHomed start of topic ===
    ${lockingPinHomed_end}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinHomed end of topic ===
    ${lockingPinHomed_list}=    Get Slice From List    ${full_list}    start=${lockingPinHomed_start}    end=${lockingPinHomed_end}
    Should Contain X Times    ${lockingPinHomed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lockingPinID : 1    1
    Should Contain X Times    ${lockingPinHomed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${centralLockingPinDisengaged_start}=    Get Index From List    ${full_list}    === ${subSystem}_centralLockingPinDisengaged start of topic ===
    ${centralLockingPinDisengaged_end}=    Get Index From List    ${full_list}    === ${subSystem}_centralLockingPinDisengaged end of topic ===
    ${centralLockingPinDisengaged_list}=    Get Slice From List    ${full_list}    start=${centralLockingPinDisengaged_start}    end=${centralLockingPinDisengaged_end}
    Should Contain X Times    ${centralLockingPinDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${centralLockingPinDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${centralLockingPinHomed_start}=    Get Index From List    ${full_list}    === ${subSystem}_centralLockingPinHomed start of topic ===
    ${centralLockingPinHomed_end}=    Get Index From List    ${full_list}    === ${subSystem}_centralLockingPinHomed end of topic ===
    ${centralLockingPinHomed_list}=    Get Slice From List    ${full_list}    start=${centralLockingPinHomed_start}    end=${centralLockingPinHomed_end}
    Should Contain X Times    ${centralLockingPinHomed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${centralLockingPinHomed_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${centralLockingPinFloating_start}=    Get Index From List    ${full_list}    === ${subSystem}_centralLockingPinFloating start of topic ===
    ${centralLockingPinFloating_end}=    Get Index From List    ${full_list}    === ${subSystem}_centralLockingPinFloating end of topic ===
    ${centralLockingPinFloating_list}=    Get Slice From List    ${full_list}    start=${centralLockingPinFloating_start}    end=${centralLockingPinFloating_end}
    Should Contain X Times    ${centralLockingPinFloating_list}    ${SPACE}${SPACE}${SPACE}${SPACE}status : 1    1
    Should Contain X Times    ${centralLockingPinFloating_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${brakeEngaged_start}=    Get Index From List    ${full_list}    === ${subSystem}_brakeEngaged start of topic ===
    ${brakeEngaged_end}=    Get Index From List    ${full_list}    === ${subSystem}_brakeEngaged end of topic ===
    ${brakeEngaged_list}=    Get Slice From List    ${full_list}    start=${brakeEngaged_start}    end=${brakeEngaged_end}
    Should Contain X Times    ${brakeEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakeId : 1    1
    Should Contain X Times    ${brakeEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${brakeDisengaged_start}=    Get Index From List    ${full_list}    === ${subSystem}_brakeDisengaged start of topic ===
    ${brakeDisengaged_end}=    Get Index From List    ${full_list}    === ${subSystem}_brakeDisengaged end of topic ===
    ${brakeDisengaged_list}=    Get Slice From List    ${full_list}    start=${brakeDisengaged_start}    end=${brakeDisengaged_end}
    Should Contain X Times    ${brakeDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakeId : 1    1
    Should Contain X Times    ${brakeDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${echoResponse_start}=    Get Index From List    ${full_list}    === ${subSystem}_echoResponse start of topic ===
    ${echoResponse_end}=    Get Index From List    ${full_list}    === ${subSystem}_echoResponse end of topic ===
    ${echoResponse_list}=    Get Slice From List    ${full_list}    start=${echoResponse_start}    end=${echoResponse_end}
    Should Contain X Times    ${echoResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}response : LSST    1
    Should Contain X Times    ${echoResponse_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${apsSubsystemError_start}=    Get Index From List    ${full_list}    === ${subSystem}_apsSubsystemError start of topic ===
    ${apsSubsystemError_end}=    Get Index From List    ${full_list}    === ${subSystem}_apsSubsystemError end of topic ===
    ${apsSubsystemError_list}=    Get Slice From List    ${full_list}    start=${apsSubsystemError_start}    end=${apsSubsystemError_end}
    Should Contain X Times    ${apsSubsystemError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : LSST    1
    Should Contain X Times    ${apsSubsystemError_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
