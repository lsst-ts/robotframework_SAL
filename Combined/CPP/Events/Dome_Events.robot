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

Read Logger
    [Tags]    functional
    Switch Process    Logger
    ${output}=    Wait For Process    handle=Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${stateChange_start}=    Get Index From List    ${full_list}    === Event stateChange received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${stateChange_start}
    ${stateChange_end}=    Evaluate    ${end}+${1}
    ${stateChange_list}=    Get Slice From List    ${full_list}    start=${stateChange_start}    end=${stateChange_end}
    Should Contain X Times    ${stateChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}newState : 1    1
    Should Contain X Times    ${stateChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${motionEnabled_start}=    Get Index From List    ${full_list}    === Event motionEnabled received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${motionEnabled_start}
    ${motionEnabled_end}=    Evaluate    ${end}+${1}
    ${motionEnabled_list}=    Get Slice From List    ${full_list}    start=${motionEnabled_start}    end=${motionEnabled_end}
    Should Contain X Times    ${motionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}motionEnabledId : 1    1
    Should Contain X Times    ${motionEnabled_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${inPosition_start}=    Get Index From List    ${full_list}    === Event inPosition received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${inPosition_start}
    ${inPosition_end}=    Evaluate    ${end}+${1}
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${inPosition_end}
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}deviceId : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}devicePosition : 1    1
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${driveFault_start}=    Get Index From List    ${full_list}    === Event driveFault received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${driveFault_start}
    ${driveFault_end}=    Evaluate    ${end}+${1}
    ${driveFault_list}=    Get Slice From List    ${full_list}    start=${driveFault_start}    end=${driveFault_end}
    Should Contain X Times    ${driveFault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveId : 1    1
    Should Contain X Times    ${driveFault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}driveFaultCode : LSST    1
    Should Contain X Times    ${driveFault_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lockingPinEngaged_start}=    Get Index From List    ${full_list}    === Event lockingPinEngaged received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${lockingPinEngaged_start}
    ${lockingPinEngaged_end}=    Evaluate    ${end}+${1}
    ${lockingPinEngaged_list}=    Get Slice From List    ${full_list}    start=${lockingPinEngaged_start}    end=${lockingPinEngaged_end}
    Should Contain X Times    ${lockingPinEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lockingPinEngagedId : 1    1
    Should Contain X Times    ${lockingPinEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${lockingPinDisengaged_start}=    Get Index From List    ${full_list}    === Event lockingPinDisengaged received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${lockingPinDisengaged_start}
    ${lockingPinDisengaged_end}=    Evaluate    ${end}+${1}
    ${lockingPinDisengaged_list}=    Get Slice From List    ${full_list}    start=${lockingPinDisengaged_start}    end=${lockingPinDisengaged_end}
    Should Contain X Times    ${lockingPinDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lockingPinDisengagedId : 1    1
    Should Contain X Times    ${lockingPinDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${overTemp_start}=    Get Index From List    ${full_list}    === Event overTemp received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${overTemp_start}
    ${overTemp_end}=    Evaluate    ${end}+${1}
    ${overTemp_list}=    Get Slice From List    ${full_list}    start=${overTemp_start}    end=${overTemp_end}
    Should Contain X Times    ${overTemp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overTempId : 1    1
    Should Contain X Times    ${overTemp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overTempValue : 1    1
    Should Contain X Times    ${overTemp_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${speedLimitReached_start}=    Get Index From List    ${full_list}    === Event speedLimitReached received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${speedLimitReached_start}
    ${speedLimitReached_end}=    Evaluate    ${end}+${1}
    ${speedLimitReached_list}=    Get Slice From List    ${full_list}    start=${speedLimitReached_start}    end=${speedLimitReached_end}
    Should Contain X Times    ${speedLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedLimitReachedId : 1    1
    Should Contain X Times    ${speedLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}speedLimitReachedValue : 1    1
    Should Contain X Times    ${speedLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${accelLimitReached_start}=    Get Index From List    ${full_list}    === Event accelLimitReached received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${accelLimitReached_start}
    ${accelLimitReached_end}=    Evaluate    ${end}+${1}
    ${accelLimitReached_list}=    Get Slice From List    ${full_list}    start=${accelLimitReached_start}    end=${accelLimitReached_end}
    Should Contain X Times    ${accelLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelLimitReachedId : 1    1
    Should Contain X Times    ${accelLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelLimitReachedValue : 1    1
    Should Contain X Times    ${accelLimitReached_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${brakeEngaged_start}=    Get Index From List    ${full_list}    === Event brakeEngaged received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${brakeEngaged_start}
    ${brakeEngaged_end}=    Evaluate    ${end}+${1}
    ${brakeEngaged_list}=    Get Slice From List    ${full_list}    start=${brakeEngaged_start}    end=${brakeEngaged_end}
    Should Contain X Times    ${brakeEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakeEngagedId : 1    1
    Should Contain X Times    ${brakeEngaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${brakeDisengaged_start}=    Get Index From List    ${full_list}    === Event brakeDisengaged received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${brakeDisengaged_start}
    ${brakeDisengaged_end}=    Evaluate    ${end}+${1}
    ${brakeDisengaged_list}=    Get Slice From List    ${full_list}    start=${brakeDisengaged_start}    end=${brakeDisengaged_end}
    Should Contain X Times    ${brakeDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}brakeDisengagedId : 1    1
    Should Contain X Times    ${brakeDisengaged_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${craneStatusChange_start}=    Get Index From List    ${full_list}    === Event craneStatusChange received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${craneStatusChange_start}
    ${craneStatusChange_end}=    Evaluate    ${end}+${1}
    ${craneStatusChange_list}=    Get Slice From List    ${full_list}    start=${craneStatusChange_start}    end=${craneStatusChange_end}
    Should Contain X Times    ${craneStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}craneStatusChangeCode : 1    1
    Should Contain X Times    ${craneStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${rearDoorStatusChange_start}=    Get Index From List    ${full_list}    === Event rearDoorStatusChange received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${rearDoorStatusChange_start}
    ${rearDoorStatusChange_end}=    Evaluate    ${end}+${1}
    ${rearDoorStatusChange_list}=    Get Slice From List    ${full_list}    start=${rearDoorStatusChange_start}    end=${rearDoorStatusChange_end}
    Should Contain X Times    ${rearDoorStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}rearDoorStatusChangeCode : 1    1
    Should Contain X Times    ${rearDoorStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${sealStatusChange_start}=    Get Index From List    ${full_list}    === Event sealStatusChange received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${sealStatusChange_start}
    ${sealStatusChange_end}=    Evaluate    ${end}+${1}
    ${sealStatusChange_list}=    Get Slice From List    ${full_list}    start=${sealStatusChange_start}    end=${sealStatusChange_end}
    Should Contain X Times    ${sealStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}seatStatusChangeCode : 1    1
    Should Contain X Times    ${sealStatusChange_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
    ${interlockAlarm_start}=    Get Index From List    ${full_list}    === Event interlockAlarm received =${SPACE}
    ${end}=    Get Index From List    ${full_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    start=${interlockAlarm_start}
    ${interlockAlarm_end}=    Evaluate    ${end}+${1}
    ${interlockAlarm_list}=    Get Slice From List    ${full_list}    start=${interlockAlarm_start}    end=${interlockAlarm_end}
    Should Contain X Times    ${interlockAlarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}interlockAlarmCode : 1    1
    Should Contain X Times    ${interlockAlarm_list}    ${SPACE}${SPACE}${SPACE}${SPACE}priority : 1    1
