*** Settings ***
Documentation    MTRotator_Events communications tests.
Force Tags    messaging    cpp    mtrotator    
Suite Setup    Log Many    ${subSystem}    ${component}    ${timeout}
Suite Teardown    Terminate All Processes
Library    OperatingSystem
Library    Collections
Library    Process
Library    String
Resource    ${EXECDIR}${/}common.robot
Resource    ${EXECDIR}${/}Global_Vars.robot

*** Variables ***
${subSystem}    MTRotator
${component}    all
${timeout}    180s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger

Start Logger
    [Tags]    functional    logger
    Comment    Start Logger.
    ${output}=    Start Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_logger    alias=${subSystem}_Logger     stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log    ${output}
    Should Be Equal    ${output.returncode}   ${NONE}
    Wait Until Keyword Succeeds    90s    5s    File Should Contain    ${EXECDIR}${/}stdout.txt    === ${subSystem} loggers ready
    ${output}=    Get File    ${EXECDIR}${/}stdout.txt
    Log    ${output}

Start Sender
    [Tags]    functional    sender    robot:continue-on-failure
    Comment    Start Sender.
    ${output}=    Run Process    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_all_sender
    Log Many    ${output.stdout}    ${output.stderr}
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_controllerState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_controllerState test messages =======
    Should Contain X Times    ${output.stdout}    === Event controllerState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_controllerState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event controllerState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_connected"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_connected test messages =======
    Should Contain X Times    ${output.stdout}    === Event connected iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_connected writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event connected generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_interlock"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_interlock test messages =======
    Should Contain X Times    ${output.stdout}    === Event interlock iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_interlock writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event interlock generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_target"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_target test messages =======
    Should Contain X Times    ${output.stdout}    === Event target iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_target writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event target generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_tracking"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_tracking test messages =======
    Should Contain X Times    ${output.stdout}    === Event tracking iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_tracking writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event tracking generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_inPosition"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_inPosition test messages =======
    Should Contain X Times    ${output.stdout}    === Event inPosition iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_inPosition writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event inPosition generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_configuration"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_configuration test messages =======
    Should Contain X Times    ${output.stdout}    === Event configuration iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_configuration writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event configuration generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_commandableByDDS"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_commandableByDDS test messages =======
    Should Contain X Times    ${output.stdout}    === Event commandableByDDS iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_commandableByDDS writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event commandableByDDS generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_lowFrequencyVibration"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_lowFrequencyVibration test messages =======
    Should Contain X Times    ${output.stdout}    === Event lowFrequencyVibration iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_lowFrequencyVibration writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event lowFrequencyVibration generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_motionLockState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_motionLockState test messages =======
    Should Contain X Times    ${output.stdout}    === Event motionLockState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_motionLockState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event motionLockState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_heartbeat"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_heartbeat test messages =======
    Should Contain X Times    ${output.stdout}    === Event heartbeat iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_heartbeat writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event heartbeat generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_clockOffset"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_clockOffset test messages =======
    Should Contain X Times    ${output.stdout}    === Event clockOffset iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_clockOffset writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event clockOffset generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_logLevel"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_logLevel test messages =======
    Should Contain X Times    ${output.stdout}    === Event logLevel iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_logLevel writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event logLevel generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_logMessage"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_logMessage test messages =======
    Should Contain X Times    ${output.stdout}    === Event logMessage iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_logMessage writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event logMessage generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_softwareVersions"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_softwareVersions test messages =======
    Should Contain X Times    ${output.stdout}    === Event softwareVersions iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_softwareVersions writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event softwareVersions generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_errorCode"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_errorCode test messages =======
    Should Contain X Times    ${output.stdout}    === Event errorCode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_errorCode writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event errorCode generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_simulationMode"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_simulationMode test messages =======
    Should Contain X Times    ${output.stdout}    === Event simulationMode iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_simulationMode writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event simulationMode generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_summaryState"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_summaryState test messages =======
    Should Contain X Times    ${output.stdout}    === Event summaryState iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_summaryState writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event summaryState generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_configurationApplied"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_configurationApplied test messages =======
    Should Contain X Times    ${output.stdout}    === Event configurationApplied iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_configurationApplied writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event configurationApplied generated =
    ${line}=    Grep File    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json    "logevent_configurationsAvailable"
    ${line}=    Remove String    ${line}    \"    \:    \,
    @{words}=    Split String    ${line}
    ${revcode}=    Set Variable    ${words}[1]
    Comment    ======= Verify ${subSystem}_configurationsAvailable test messages =======
    Should Contain X Times    ${output.stdout}    === Event configurationsAvailable iseq = 0    1
    Should Contain X Times    ${output.stdout}    === [putSample] ${subSystem}.logevent_configurationsAvailable writing a message containing :    1
    Should Contain    ${output.stdout}    revCode \ : ${revcode}
    Should Contain    ${output.stdout}    === Event configurationsAvailable generated =

Read Logger
    [Tags]    functional    logger    robot:continue-on-failure
    Switch Process    ${subSystem}_Logger
    ${output}=    Wait For Process    handle=${subSystem}_Logger    timeout=${timeout}    on_timeout=terminate
    Log Many    ${output.stdout}    ${output.stderr}
    @{full_list}=    Split To Lines    ${output.stdout}    start=0
    Log Many    @{full_list}
    Should Not Contain    ${output.stderr}    1/1 brokers are down
    Should Not Contain    ${output.stderr}    Consume failed
    Should Not Contain    ${output.stderr}    Broker: Unknown topic or partition
    Should Contain    ${output.stdout}    === ${subSystem} loggers ready
    ${controllerState_start}=    Get Index From List    ${full_list}    === Event controllerState received =${SPACE}
    ${end}=    Evaluate    ${controllerState_start}+${6}
    ${controllerState_list}=    Get Slice From List    ${full_list}    start=${controllerState_start}    end=${end}
    Should Contain X Times    ${controllerState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}controllerState : 1    1
    Should Contain X Times    ${controllerState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}faultSubstate : 1    1
    Should Contain X Times    ${controllerState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}enabledSubstate : 1    1
    Should Contain X Times    ${controllerState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}applicationStatus : 1    1
    ${connected_start}=    Get Index From List    ${full_list}    === Event connected received =${SPACE}
    ${end}=    Evaluate    ${connected_start}+${3}
    ${connected_list}=    Get Slice From List    ${full_list}    start=${connected_start}    end=${end}
    Should Contain X Times    ${connected_list}    ${SPACE}${SPACE}${SPACE}${SPACE}connected : 1    1
    ${interlock_start}=    Get Index From List    ${full_list}    === Event interlock received =${SPACE}
    ${end}=    Evaluate    ${interlock_start}+${3}
    ${interlock_list}=    Get Slice From List    ${full_list}    start=${interlock_start}    end=${end}
    Should Contain X Times    ${interlock_list}    ${SPACE}${SPACE}${SPACE}${SPACE}engaged : 1    1
    ${target_start}=    Get Index From List    ${full_list}    === Event target received =${SPACE}
    ${end}=    Evaluate    ${target_start}+${5}
    ${target_list}=    Get Slice From List    ${full_list}    start=${target_start}    end=${end}
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}position : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocity : 1    1
    Should Contain X Times    ${target_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tai : 1    1
    ${tracking_start}=    Get Index From List    ${full_list}    === Event tracking received =${SPACE}
    ${end}=    Evaluate    ${tracking_start}+${5}
    ${tracking_list}=    Get Slice From List    ${full_list}    start=${tracking_start}    end=${end}
    Should Contain X Times    ${tracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}tracking : 1    1
    Should Contain X Times    ${tracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lost : 1    1
    Should Contain X Times    ${tracking_list}    ${SPACE}${SPACE}${SPACE}${SPACE}noNewCommand : 1    1
    ${inPosition_start}=    Get Index From List    ${full_list}    === Event inPosition received =${SPACE}
    ${end}=    Evaluate    ${inPosition_start}+${3}
    ${inPosition_list}=    Get Slice From List    ${full_list}    start=${inPosition_start}    end=${end}
    Should Contain X Times    ${inPosition_list}    ${SPACE}${SPACE}${SPACE}${SPACE}inPosition : 1    1
    ${configuration_start}=    Get Index From List    ${full_list}    === Event configuration received =${SPACE}
    ${end}=    Evaluate    ${configuration_start}+${15}
    ${configuration_list}=    Get Slice From List    ${full_list}    start=${configuration_start}    end=${end}
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionAngleLowerLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionAngleUpperLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}velocityLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}accelerationLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}emergencyAccelerationLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}emergencyJerkLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}positionErrorThreshold : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}followingErrorThreshold : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackingSuccessPositionThreshold : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}trackingLostTimeout : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}disableLimitMaxTime : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}maxConfigurableVelocityLimit : 1    1
    Should Contain X Times    ${configuration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}drivesEnabled : 1    1
    ${commandableByDDS_start}=    Get Index From List    ${full_list}    === Event commandableByDDS received =${SPACE}
    ${end}=    Evaluate    ${commandableByDDS_start}+${3}
    ${commandableByDDS_list}=    Get Slice From List    ${full_list}    start=${commandableByDDS_start}    end=${end}
    Should Contain X Times    ${commandableByDDS_list}    ${SPACE}${SPACE}${SPACE}${SPACE}state : 1    1
    ${lowFrequencyVibration_start}=    Get Index From List    ${full_list}    === Event lowFrequencyVibration received =${SPACE}
    ${end}=    Evaluate    ${lowFrequencyVibration_start}+${3}
    ${lowFrequencyVibration_list}=    Get Slice From List    ${full_list}    start=${lowFrequencyVibration_start}    end=${end}
    Should Contain X Times    ${lowFrequencyVibration_list}    ${SPACE}${SPACE}${SPACE}${SPACE}frequency : 1    1
    ${motionLockState_start}=    Get Index From List    ${full_list}    === Event motionLockState received =${SPACE}
    ${end}=    Evaluate    ${motionLockState_start}+${4}
    ${motionLockState_list}=    Get Slice From List    ${full_list}    start=${motionLockState_start}    end=${end}
    Should Contain X Times    ${motionLockState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lockState : 1    1
    Should Contain X Times    ${motionLockState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}identity : RO    1
    ${heartbeat_start}=    Get Index From List    ${full_list}    === Event heartbeat received =${SPACE}
    ${end}=    Evaluate    ${heartbeat_start}+${2}
    ${heartbeat_list}=    Get Slice From List    ${full_list}    start=${heartbeat_start}    end=${end}
    ${clockOffset_start}=    Get Index From List    ${full_list}    === Event clockOffset received =${SPACE}
    ${end}=    Evaluate    ${clockOffset_start}+${3}
    ${clockOffset_list}=    Get Slice From List    ${full_list}    start=${clockOffset_start}    end=${end}
    Should Contain X Times    ${clockOffset_list}    ${SPACE}${SPACE}${SPACE}${SPACE}offset : 1    1
    ${logLevel_start}=    Get Index From List    ${full_list}    === Event logLevel received =${SPACE}
    ${end}=    Evaluate    ${logLevel_start}+${4}
    ${logLevel_list}=    Get Slice From List    ${full_list}    start=${logLevel_start}    end=${end}
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logLevel_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystem : RO    1
    ${logMessage_start}=    Get Index From List    ${full_list}    === Event logMessage received =${SPACE}
    ${end}=    Evaluate    ${logMessage_start}+${11}
    ${logMessage_list}=    Get Slice From List    ${full_list}    start=${logMessage_start}    end=${end}
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}name : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}level : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}message : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}filePath : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}functionName : RO    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}lineNumber : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}process : 1    1
    Should Contain X Times    ${logMessage_list}    ${SPACE}${SPACE}${SPACE}${SPACE}timestamp : 1    1
    ${softwareVersions_start}=    Get Index From List    ${full_list}    === Event softwareVersions received =${SPACE}
    ${end}=    Evaluate    ${softwareVersions_start}+${7}
    ${softwareVersions_list}=    Get Slice From List    ${full_list}    start=${softwareVersions_start}    end=${end}
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}salVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}xmlVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}openSpliceVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}cscVersion : RO    1
    Should Contain X Times    ${softwareVersions_list}    ${SPACE}${SPACE}${SPACE}${SPACE}subsystemVersions : RO    1
    ${errorCode_start}=    Get Index From List    ${full_list}    === Event errorCode received =${SPACE}
    ${end}=    Evaluate    ${errorCode_start}+${5}
    ${errorCode_list}=    Get Slice From List    ${full_list}    start=${errorCode_start}    end=${end}
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorCode : 1    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}errorReport : RO    1
    Should Contain X Times    ${errorCode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}traceback : RO    1
    ${simulationMode_start}=    Get Index From List    ${full_list}    === Event simulationMode received =${SPACE}
    ${end}=    Evaluate    ${simulationMode_start}+${3}
    ${simulationMode_list}=    Get Slice From List    ${full_list}    start=${simulationMode_start}    end=${end}
    Should Contain X Times    ${simulationMode_list}    ${SPACE}${SPACE}${SPACE}${SPACE}mode : 1    1
    ${summaryState_start}=    Get Index From List    ${full_list}    === Event summaryState received =${SPACE}
    ${end}=    Evaluate    ${summaryState_start}+${3}
    ${summaryState_list}=    Get Slice From List    ${full_list}    start=${summaryState_start}    end=${end}
    Should Contain X Times    ${summaryState_list}    ${SPACE}${SPACE}${SPACE}${SPACE}summaryState : 1    1
    ${configurationApplied_start}=    Get Index From List    ${full_list}    === Event configurationApplied received =${SPACE}
    ${end}=    Evaluate    ${configurationApplied_start}+${7}
    ${configurationApplied_list}=    Get Slice From List    ${full_list}    start=${configurationApplied_start}    end=${end}
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}configurations : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}schemaVersion : RO    1
    Should Contain X Times    ${configurationApplied_list}    ${SPACE}${SPACE}${SPACE}${SPACE}otherInfo : RO    1
    ${configurationsAvailable_start}=    Get Index From List    ${full_list}    === Event configurationsAvailable received =${SPACE}
    ${end}=    Evaluate    ${configurationsAvailable_start}+${6}
    ${configurationsAvailable_list}=    Get Slice From List    ${full_list}    start=${configurationsAvailable_start}    end=${end}
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}overrides : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}version : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}url : RO    1
    Should Contain X Times    ${configurationsAvailable_list}    ${SPACE}${SPACE}${SPACE}${SPACE}schemaVersion : RO    1
