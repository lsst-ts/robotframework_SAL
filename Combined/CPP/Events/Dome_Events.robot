*** Settings ***
Documentation    Dome_Events communications tests.
Force Tags    cpp    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    Dome
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
    Comment    ======= Verify ${subSystem}_stateChange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_stateChange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event stateChange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_stateChange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event stateChange generated =
    Comment    ======= Verify ${subSystem}_motionEnabled test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_motionEnabled
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event motionEnabled iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_motionEnabled_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event motionEnabled generated =
    Comment    ======= Verify ${subSystem}_inPosition test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_inPosition
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event inPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_inPosition_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event inPosition generated =
    Comment    ======= Verify ${subSystem}_driveFault test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_driveFault
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event driveFault iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_driveFault_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event driveFault generated =
    Comment    ======= Verify ${subSystem}_lockingPinEngaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_lockingPinEngaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event lockingPinEngaged iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_lockingPinEngaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event lockingPinEngaged generated =
    Comment    ======= Verify ${subSystem}_lockingPinDisengaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_lockingPinDisengaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event lockingPinDisengaged iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_lockingPinDisengaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event lockingPinDisengaged generated =
    Comment    ======= Verify ${subSystem}_overTemp test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_overTemp
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event overTemp iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_overTemp_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event overTemp generated =
    Comment    ======= Verify ${subSystem}_speedLimitReached test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_speedLimitReached
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event speedLimitReached iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_speedLimitReached_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event speedLimitReached generated =
    Comment    ======= Verify ${subSystem}_accelLimitReached test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_accelLimitReached
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event accelLimitReached iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_accelLimitReached_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event accelLimitReached generated =
    Comment    ======= Verify ${subSystem}_brakeEngaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_brakeEngaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event brakeEngaged iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_brakeEngaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event brakeEngaged generated =
    Comment    ======= Verify ${subSystem}_brakeDisengaged test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_brakeDisengaged
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event brakeDisengaged iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_brakeDisengaged_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event brakeDisengaged generated =
    Comment    ======= Verify ${subSystem}_craneStatusChange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_craneStatusChange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event craneStatusChange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_craneStatusChange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event craneStatusChange generated =
    Comment    ======= Verify ${subSystem}_rearDoorStatusChange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_rearDoorStatusChange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event rearDoorStatusChange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_rearDoorStatusChange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event rearDoorStatusChange generated =
    Comment    ======= Verify ${subSystem}_sealStatusChange test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_sealStatusChange
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event sealStatusChange iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_sealStatusChange_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event sealStatusChange generated =
    Comment    ======= Verify ${subSystem}_interlockAlarm test messages =======
    ${line}=    Grep File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl    ${subSystem}_logevent_interlockAlarm
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    @{words}[2]
    Should Contain X Times    ${output.stdout}    === Event interlockAlarm iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}::logevent_interlockAlarm_${revcode} writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}    10
    Should Contain    ${output.stdout}    === Event interlockAlarm generated =
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
    ${stateChange_start}=    Get Index From List    ${full_list}    === ${subSystem}_stateChange start of topic ===
    ${stateChange_end}=    Get Index From List    ${full_list}    === ${subSystem}_stateChange end of topic ===
    ${stateChange_list}=    Get Slice From List    ${full_list}    start=${stateChange_start}    end=${stateChange_end}
    Should Contain X Times    ${stateChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}newState : 1    1
    Should Contain X Times    ${stateChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${motionEnabled_start}=    Get Index From List    ${full_list}    === ${subSystem}_motionEnabled start of topic ===
    ${motionEnabled_end}=    Get Index From List    ${full_list}    === ${subSystem}_motionEnabled end of topic ===
    ${motionEnabled_list}=    Get Slice From List    ${full_list}    start=${motionEnabled_start}    end=${motionEnabled_end}
    Should Contain X Times    ${motionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionEnabledId : 1    1
    Should Contain X Times    ${motionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPosition_start}=    Get Index From List    ${full_list}    === ${subSystem}_inPosition start of topic ===
    ${inPosition_end}=    Get Index From List    ${full_list}    === ${subSystem}_inPosition end of topic ===
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${inPosition_end}
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deviceId : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}devicePosition : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${driveFault_start}=    Get Index From List    ${full_list}    === ${subSystem}_driveFault start of topic ===
    ${driveFault_end}=    Get Index From List    ${full_list}    === ${subSystem}_driveFault end of topic ===
    ${driveFault_list}=    Get Slice From List    ${full_list}    start=${driveFault_start}    end=${driveFault_end}
    Should Contain X Times    ${driveFault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveId : 1    1
    Should Contain X Times    ${driveFault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveFaultCode : LSST    1
    Should Contain X Times    ${driveFault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lockingPinEngaged_start}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinEngaged start of topic ===
    ${lockingPinEngaged_end}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinEngaged end of topic ===
    ${lockingPinEngaged_list}=    Get Slice From List    ${full_list}    start=${lockingPinEngaged_start}    end=${lockingPinEngaged_end}
    Should Contain X Times    ${lockingPinEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lockingPinEngagedId : 1    1
    Should Contain X Times    ${lockingPinEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lockingPinDisengaged_start}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinDisengaged start of topic ===
    ${lockingPinDisengaged_end}=    Get Index From List    ${full_list}    === ${subSystem}_lockingPinDisengaged end of topic ===
    ${lockingPinDisengaged_list}=    Get Slice From List    ${full_list}    start=${lockingPinDisengaged_start}    end=${lockingPinDisengaged_end}
    Should Contain X Times    ${lockingPinDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lockingPinDisengagedId : 1    1
    Should Contain X Times    ${lockingPinDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${overTemp_start}=    Get Index From List    ${full_list}    === ${subSystem}_overTemp start of topic ===
    ${overTemp_end}=    Get Index From List    ${full_list}    === ${subSystem}_overTemp end of topic ===
    ${overTemp_list}=    Get Slice From List    ${full_list}    start=${overTemp_start}    end=${overTemp_end}
    Should Contain X Times    ${overTemp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overTempId : 1    1
    Should Contain X Times    ${overTemp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overTempValue : 1    1
    Should Contain X Times    ${overTemp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${speedLimitReached_start}=    Get Index From List    ${full_list}    === ${subSystem}_speedLimitReached start of topic ===
    ${speedLimitReached_end}=    Get Index From List    ${full_list}    === ${subSystem}_speedLimitReached end of topic ===
    ${speedLimitReached_list}=    Get Slice From List    ${full_list}    start=${speedLimitReached_start}    end=${speedLimitReached_end}
    Should Contain X Times    ${speedLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedLimitReachedId : 1    1
    Should Contain X Times    ${speedLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedLimitReachedValue : 1    1
    Should Contain X Times    ${speedLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${accelLimitReached_start}=    Get Index From List    ${full_list}    === ${subSystem}_accelLimitReached start of topic ===
    ${accelLimitReached_end}=    Get Index From List    ${full_list}    === ${subSystem}_accelLimitReached end of topic ===
    ${accelLimitReached_list}=    Get Slice From List    ${full_list}    start=${accelLimitReached_start}    end=${accelLimitReached_end}
    Should Contain X Times    ${accelLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelLimitReachedId : 1    1
    Should Contain X Times    ${accelLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelLimitReachedValue : 1    1
    Should Contain X Times    ${accelLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${brakeEngaged_start}=    Get Index From List    ${full_list}    === ${subSystem}_brakeEngaged start of topic ===
    ${brakeEngaged_end}=    Get Index From List    ${full_list}    === ${subSystem}_brakeEngaged end of topic ===
    ${brakeEngaged_list}=    Get Slice From List    ${full_list}    start=${brakeEngaged_start}    end=${brakeEngaged_end}
    Should Contain X Times    ${brakeEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakeEngagedId : 1    1
    Should Contain X Times    ${brakeEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${brakeDisengaged_start}=    Get Index From List    ${full_list}    === ${subSystem}_brakeDisengaged start of topic ===
    ${brakeDisengaged_end}=    Get Index From List    ${full_list}    === ${subSystem}_brakeDisengaged end of topic ===
    ${brakeDisengaged_list}=    Get Slice From List    ${full_list}    start=${brakeDisengaged_start}    end=${brakeDisengaged_end}
    Should Contain X Times    ${brakeDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakeDisengagedId : 1    1
    Should Contain X Times    ${brakeDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${craneStatusChange_start}=    Get Index From List    ${full_list}    === ${subSystem}_craneStatusChange start of topic ===
    ${craneStatusChange_end}=    Get Index From List    ${full_list}    === ${subSystem}_craneStatusChange end of topic ===
    ${craneStatusChange_list}=    Get Slice From List    ${full_list}    start=${craneStatusChange_start}    end=${craneStatusChange_end}
    Should Contain X Times    ${craneStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}craneStatusChangeCode : 1    1
    Should Contain X Times    ${craneStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rearDoorStatusChange_start}=    Get Index From List    ${full_list}    === ${subSystem}_rearDoorStatusChange start of topic ===
    ${rearDoorStatusChange_end}=    Get Index From List    ${full_list}    === ${subSystem}_rearDoorStatusChange end of topic ===
    ${rearDoorStatusChange_list}=    Get Slice From List    ${full_list}    start=${rearDoorStatusChange_start}    end=${rearDoorStatusChange_end}
    Should Contain X Times    ${rearDoorStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rearDoorStatusChangeCode : 1    1
    Should Contain X Times    ${rearDoorStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sealStatusChange_start}=    Get Index From List    ${full_list}    === ${subSystem}_sealStatusChange start of topic ===
    ${sealStatusChange_end}=    Get Index From List    ${full_list}    === ${subSystem}_sealStatusChange end of topic ===
    ${sealStatusChange_list}=    Get Slice From List    ${full_list}    start=${sealStatusChange_start}    end=${sealStatusChange_end}
    Should Contain X Times    ${sealStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seatStatusChangeCode : 1    1
    Should Contain X Times    ${sealStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${interlockAlarm_start}=    Get Index From List    ${full_list}    === ${subSystem}_interlockAlarm start of topic ===
    ${interlockAlarm_end}=    Get Index From List    ${full_list}    === ${subSystem}_interlockAlarm end of topic ===
    ${interlockAlarm_list}=    Get Slice From List    ${full_list}    start=${interlockAlarm_start}    end=${interlockAlarm_end}
    Should Contain X Times    ${interlockAlarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}interlockAlarmCode : 1    1
    Should Contain X Times    ${interlockAlarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
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
